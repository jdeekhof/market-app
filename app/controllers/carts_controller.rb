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
    @applicable_promotions = @cart.find_applicable_promotions
  end

  private

  def cart_params
    params.permit(:id)
  end
end
