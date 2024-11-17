class ProductsController < ApplicationController
  def index; end

  def new
    @product = Product.new
    @category = Category.new
  end

  def create; end
end
