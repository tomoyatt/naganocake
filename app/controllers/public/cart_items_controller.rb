class Public::CartItemsController < ApplicationController
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = params[:item_id]
    if @cart_item.save
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
      redirect_to cart_items_path
    else
      flash[:notice] = "個数を選択してください。"
      redirect_back(fallback_location: items_path)
    end
  end
  
  def index
  end
  
  def update
  end
  
  def destroy
  end
  
  def destroy_all
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
  
end
