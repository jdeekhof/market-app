class CartsController < ApplicationController
  def new
    @cart = Cart.create!
  end

  def checkout
    @cart = Cart.find(cart_params[:id])
    @cart_items = @cart.cart_items.ordered_by_category
    @checkout = ::Checkout.new(cart: @cart)
  end

  def show
    @cart = Cart.find(cart_params[:id])
    @cart_items = @cart.cart_items.ordered_by_category
    products_in_cart = Product.where(id: @cart_items.where(promotion_id: nil).pluck(:product_id))
    @applicable_promotions =
      Promotion.occurring_now.product_or_category_related(products: products_in_cart).uniq
    @applicable_promotions.filter! do |promotion|
      @cart_items.find_by!(product_id: promotion.promotionable.id).quantity >= promotion.minimum_quantity
    end
  end

  private

  def cart_params
    params.permit(:id)
  end
end
