class CartsController < ApplicationController
  def new
    @cart = Cart.create!
  end

  def create
  end

  def show
    @cart = Cart.find(cart_params[:id])
  end

  def add_product
    @cart = Cart.find(cart_params[:id])
    @product = Product.find(product_params[:product_id])
    @cart.add_product(product_id: @product.id, quantity: product_params[:quantity].to_i)
    redirect_to cart_path(@cart), notice: "Item added to cart."
  end

  private

  def product_params
    params.permit(:product_id, :quantity)
  end

  def cart_params
    params.permit(:id)
  end
end