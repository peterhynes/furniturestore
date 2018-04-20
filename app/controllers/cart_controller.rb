class CartController < ApplicationController
  before_action :authenticate_user!
  def index
    # pass the information to the view page of cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
    
  end
  
  def add
    # get the id of the product we want to add
    id = params[:id]
    
    # if the session is alreary there use that if not make a new session
    
    if session[:cart]
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end
    
    # if the product is already in the cart increase the quantity by 1
    
    if cart[id] then
      cart[id] = cart[id] + 1
    else
      cart[id] = 1
    end
    
    redirect_to :action => :index
    
  end
  
  
  def remove
    
    id = params[:id]
    cart = session[:cart]
      if cart[id] == 1 then
        cart.delete id
      else
        cart[id] = cart[id] - 1
      end
    
    redirect_to :action => :index
    
  end
  
  def clearCart
    session[:cart] = nil
    redirect_to :action => :index
  end
  
  
  def createOrder
    
    # step 1 : get current user id
    
    @user = User.find(current_user.id)
    
    @user.save
    
    # step 2 : Build order based on current user and their order details + populate order db table
    
    @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
    
    @order.save
    
    # step 3 : Move cart items to now be orderitems
    
    @cart = session[:cart] || {} # Get content of current cart
    
    @cart.each do |id, quantity|
      
      item = Item.find_by_id(id)
      
      @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price => item.price)
      
      @orderitem.save
      
    end
    
    @orders = Order.all
    
    @orderitems = Orderitem.where(order_id: Order.last)
    
  end
  
  
end
