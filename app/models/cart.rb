class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id:, quantity:)
    item = cart_items.find_or_initialize_by(product_id:)
    previous_quantity = item.quantity || 0
    item.quantity = previous_quantity + quantity.to_i
    item.save!
  end

  def remove_product(product_id:)
    cart_items.find_by(product_id:).destroy
  end
end