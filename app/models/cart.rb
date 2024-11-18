class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id, quantity)
    item = cart_items.find_or_create_by!(product_id: product_id)
    item.quantity += quantity
    item.save
  end
end