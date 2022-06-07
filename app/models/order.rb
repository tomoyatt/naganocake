class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
  
  enum payment_method: {
    credit_card: 0, transfer: 1
  }
  
  enum status: {
    awaiting_payment: 0,
    payment_confirmationunder: 1,
    in_production: 2,
    shipping_preparation: 3,
    shipped: 4
  }
end
