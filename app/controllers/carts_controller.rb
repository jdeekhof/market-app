class CartsController < ApplicationController
  def new
    @cart = Cart.create!
  end

  def create
  end

  def show
    @cart = Cart.find(cart_params[:id])
    @cart_items = @cart.cart_items
    @applicable_promotions = Promotion.all
  end

  private

  def cart_params
    params.permit(:id)
  end
end