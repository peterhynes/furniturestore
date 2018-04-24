class StaticPagesController < ApplicationController
  def home
    @categories = Category.all
    @items = Item.all
  end

  def help
  end

  def about
  end
  
  def category
    
    catName = params[:title]
    @items = Item.where("category like ?", catName)
    
  end
  
  def paid
    @order = Order.last
    @order.update_attribute(:status, "Paid in full by #{current_user.email}")
    
    session[:cart] = nil
    @items = Item.all
  end
  
  def search
    st = "%#{params[:srcbx]}%"
    @items = Item.where("title like ?", st)
  end
  
end
