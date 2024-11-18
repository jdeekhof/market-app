class Category < ApplicationRecord
  validates_uniqueness_of :name
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/ }
end
