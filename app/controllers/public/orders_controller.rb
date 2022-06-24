class Public::OrdersController < ApplicationController
  
  before_action :authenticate_customer
  
  def new
    @order = Order.new
  end
  
  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    destination = params[:order][:select_address]
    @order.shipping_cost = 800
    @order.status = 0
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.price * 1.1 * cart_item.amount).floor
    end
    @order.total_payment = @total_price + @order.shipping_cost
    
    if destination == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif destination == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif destination == "2"
      @address = Address.new()
      @address.postal_code = params[:order][:postal_code]
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.customer_id = current_customer.id
      if @address.save
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      else
        render :new
      end
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.making_status = 0
      @order_detail.price = @order.total_payment
      @order_detail.save
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end
  
  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :status, :total_payment)
  end
end
