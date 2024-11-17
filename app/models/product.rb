class Product < ApplicationRecord
  validates_presence_of :name, :category, :units_of_sale, :cents_price_per_unit
  validates_uniqueness_of :name

  enum :units_of_sale,  [ :discrete, :per_gram, :per_pound, :per_ton ]
end
