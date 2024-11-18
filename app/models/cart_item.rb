class CartItem < ApplicationRecord
  validates_presence_of :cart, :product
  validates :quantity, numericality: { more_than: 0 }
  belongs_to :cart
  belongs_to :product
end