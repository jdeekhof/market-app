class Promotion < ApplicationRecord
  validates_presence_of :code, :begins_at, :minimum_quantity, :units_of_discount, :discount_type
  validates :cents_discount_scalar, numericality: { more_than: 0 }
  enum :discount_type, [:flat, :percentage]
  enum :units_of_discount,  [ :discrete, :per_gram, :per_pound, :per_ton ]


end