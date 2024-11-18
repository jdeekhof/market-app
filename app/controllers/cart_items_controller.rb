class CartItemsController < ApplicationController
  def create
    @cart = Cart.find(cart_params[:cart_id])
    @product = Product.find(product_params[:id])
    @cart.add_product(product_id: @product.id, quantity: product_params[:quantity].to_i)
    redirect_to cart_path(@cart)
  end

  def update
    @cart = Cart.find(cart_params[:cart_id])
    promotion = Promotion.find(promotion_params[:promotion_id])
    cart_items = @cart.cart_items.undiscounted
    promotion.promotionable.add_promotion(promotion:, cart_items:)
    redirect_to cart_path(@cart)
  end

  def destroy
    @cart = Cart.find(cart_params[:cart_id])
    @product = Product.find(product_params[:id])
    @cart.remove_product(product_id: @product.id)
    redirect_to cart_path(@cart)
  end

  private

  def cart_params
    params.permit :cart_id
  end

  def product_params
    params.permit :id, :quantity
  end

  def promotion_params
    params.permit :promotion_id
  end
end
