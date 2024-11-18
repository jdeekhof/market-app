class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def checkout!
    puts cart_items
  end

  def find_applicable_promotions
    products_in_cart = Product.where(id: cart_items.undiscounted.pluck(:product_id))
    applicable_promotions = Promotion.occurring_now.product_or_category_related(products: products_in_cart).uniq
    applicable_promotions.filter! do |promotion|
      promotion.promotionable.full_quantity_in_cart >= promotion.minimum_quantity
    end
  end

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
