class Public::CartItemsController < ApplicationController
  
  before_action :authenticate_customer
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
    else
      redirect_back(fallback_location: items_path)
      flash[:notice] = "個数を選択してください。"
    end
  end
  
  def index
    @cart_items = current_customer.cart_items
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
  
end
