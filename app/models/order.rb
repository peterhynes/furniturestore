class Order < ApplicationRecord
  belongs_to :user
  
  def order_params
    
    params.required(:order).permit(:order_date, :user_id)
    
  end
  
  has_many:orderitems
  belongs_to:user
  
end
