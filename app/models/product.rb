class Product < ApplicationRecord
  validates_presence_of :name, :category, :units_of_sale, :cents_price_per_unit
  validates_uniqueness_of :name
  belongs_to :category
  enum :units_of_sale,  [ :discrete, :gram, :pound, :ton ]

  def full_quantity_in_cart(cart_items:)
    cart_items.find_by!(product_id: id).quantity
  end

  def add_promotion(promotion:, cart_items:)
    cart_items.find_by!(
      product: self
    ).add_promotion(promotion)
  end
end
