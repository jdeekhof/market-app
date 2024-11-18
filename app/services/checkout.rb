class Checkout < ApplicationService
  attr_reader :cart_items, :line_items_hash, :full_total

  def initialize(cart:)
    @cart_items = cart.cart_items
    @line_items_hash = {}
    calculate_cart_item_totals
    @full_total = calculate_total_total
  end

  def item_total(item:)
    line_items_hash[item.product_id]
  end

  private

  def calculate_total_total
    line_items_hash.values.sum
  end

  def calculate_cart_item_totals
    cart_items.each do |item|
      line_items_hash[item.product_id] = sum_cart_item(item:)
    end
  end

  def sum_cart_item(item:)
    return cents_subtotal(item:) if item.promotion.nil?
    discounted = (cents_subtotal(item:) - cents_discount(item:, promotion: item.promotion))
    discounted <= 0 ? 0 : discounted
  end

  def cents_subtotal(item:)
    item.product.cents_price_per_unit * item.quantity
  end

  def cents_discount(item:, promotion:)
    if promotion.flat?
      flat_discount(promotion:)
    else
      percentage_discount(item:, promotion:)
    end
  end

  def flat_discount(promotion:)
    promotion.cents_discount_scalar
  end

  def percentage_discount(item:, promotion:)
    item.product.cents_price_per_unit * item.quantity * (promotion.cents_discount_scalar/100.00)
  end
end
