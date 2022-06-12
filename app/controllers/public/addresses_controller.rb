class Public::AddressesController < ApplicationController
  
  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      @addresses = Address.all
      flash[:notice] = "error"
      render :index
    end
  end
  
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
  
end
