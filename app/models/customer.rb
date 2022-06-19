class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items
  has_many :order_details
  has_many :addresses
  
  validates :last_name,         presence: true
  validates :first_name,        presence: true
  validates :last_name_kana,    presence: true
  validates :first_name_kana,   presence: true
  validates :postal_code,       presence: true
  validates :address,           presence: true
  validates :telephone_number,  presence: true
  
  def address_display
    '〒' + postal_code + ' ' + address
  end
  
  def full_name_display
    last_name + first_name
  end
end
