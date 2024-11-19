class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def create
    discount_type = Promotion.discount_types.keys[create_params[:discount_type].to_i]
    if discount_type == "flat"
      scalar = ::DollarsToCentsConverter.call!(
        dollars: create_params[:discount_scalar],
        cents: create_params[:discount_scalar_cents]
      )
    else
      scalar = create_params[:discount_scalar]
    end
    promotionable = find_promotionable_from_params(create_params[:promotionable])
    promotion = Promotion.create(
      code: create_params[:code],
      promotionable:,
      begins_at: create_params[:begins_at],
      ends_at: create_params[:ends_at],
      minimum_quantity: create_params[:minimum_quantity],
      discount_type:,
      cents_discount_scalar: scalar,
    )
    if promotion.save
      flash.notice = "Promotion Saved!"
      redirect_to promotions_path
    else
      flash.alert = promotion.errors
      redirect_to new_promotion_path
    end
  end

  private

  def create_params
    params.require(:promotion).permit(
      :code,
      :promotionable,
      :begins_at,
      :ends_at,
      :minimum_quantity,
      :discount_type,
      :discount_scalar,
      :discount_scalar_cents,
    )
  end

  def find_promotionable_from_params(promotionable_params)
    parsed = promotionable_params.split("#") # [promotionable.class.name, promotionable.id ]
    parsed.first.constantize.find(parsed.last)
  end
end
