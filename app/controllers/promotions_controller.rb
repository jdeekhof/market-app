class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def create
    discount_type = Promotion.discount_types.keys[create_params[:discount_type].to_i]
    if discount_type == 'flat'
      scalar = ::DollarsToCentsConverter.call!(
        dollars: create_params[:discount_scalar],
        cents: create_params[:discount_scalar_cents]
      )
    else
      scalar = create_params[:discount_scalar]
    end
    Promotion.create!(
      code: create_params[:code],
      begins_at: create_params[:begins_at],
      ends_at: create_params[:ends_at],
      minimum_quantity: create_params[:minimum_quantity],
      units_of_discount: Promotion.units_of_discounts.keys[create_params[:units_of_discount].to_i] ,
      discount_type:,
      cents_discount_scalar: scalar,
    )
    redirect_to promotions_path
  end

  private

  def create_params
    params.require(:promotion).permit(
      :code, :begins_at, :ends_at, :minimum_quantity, :units_of_discount, :discount_type, :discount_scalar, :discount_scalar_cents
    )
  end
end
