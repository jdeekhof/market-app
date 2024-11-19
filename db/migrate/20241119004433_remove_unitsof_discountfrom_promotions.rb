class RemoveUnitsofDiscountfromPromotions < ActiveRecord::Migration[8.0]
  def change
    remove_column :promotions, :units_of_discount
  end
end
