class Promotion < ApplicationRecord
  validates_presence_of :code, :begins_at, :minimum_quantity, :discount_type
  validates :cents_discount_scalar, numericality: { more_than: 0 }
  validates :begins_at, comparison: { less_than: :ends_at }, if: :ends_at
  enum :discount_type, [ :flat, :percentage]
  belongs_to :promotionable, polymorphic: true

  scope :occurring_now, -> { where('NOW() BETWEEN begins_at AND COALESCE(ends_at, NOW())') }
  scope :product_or_category_related,-> (products:) do
    where(promotionable_type: Category.to_s, promotionable_id: products.pluck(:category_id)
    ).or(
      Promotion.where(promotionable_type: Product.to_s, promotionable_id: products.ids)
    )
  end
end
