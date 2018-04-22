class UserController < ApplicationController
  
  def login
    session[:login] = 1
    flash[:notice] = "You are logged in"
    redirect_to :controller => :items
  end
  
  def logout
    session[:cart] = nil
    session[:login] = nil
    flash[:notice] = "You logged out"
    redirect_to :controller => :items
  end
  
  def welcome
    @user = User.find(current_user.id)
    @orders = @user.orders.all
    @order = Order.where(order_id: params[:id])
    @orderitems = Orderitem.where(order_id: params[:id])
  end
  
end
