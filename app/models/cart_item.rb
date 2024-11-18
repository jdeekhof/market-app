class CartItem < ApplicationRecord
  validates_presence_of :cart, :product
  validates :quantity, numericality: { more_than: 0 }
  belongs_to :cart
  belongs_to :product
  belongs_to :promotion, required: false

  scope :undiscounted, -> { where(promotion_id: nil) }
  scope :ordered_by_category, ->{ joins(:product).order(product: {category_id: :ASC}) }

  def human_units_of_sale
    Rails.logger.info(product.units_of_sale == "discrete")
    return "#{quantity}" if product.units_of_sale == "discrete"
    return "#{quantity} #{product.units_of_sale}" if quantity == 1
    "#{quantity} #{product.units_of_sale}s"
  end

  def add_promotion(promotion)
    update!(promotion:)
  end
end
