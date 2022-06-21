class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirm
    customer = current_customer
    params[:order][:payment_method] = params[:order][:payment_method].to_i
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    destination = params[:order][:address_number]
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.price * 1.1 * cart_item.amount).floor
    end
    
    if destination == 0
      @order.postal_code = customer.postal_code
      @order.address = customer.address
      @order.name = customer.last_name + customer.first_name
    elsif destination == 1
      address = Address.find(params[:order][:address])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    elsif destination == 2
      @address = Address.new()
      @address.postal_code = params[:order][:postal_code]
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.customer_id = customer.id
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
  end
  
  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end
  
  private
  
  def order_params
    params.permit(:payment_method, :address, :shipping_cost, :postal_code, :name)
  end
end
