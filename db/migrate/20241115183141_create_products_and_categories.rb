class CreateProductsAndCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps
    end

    create_table :products do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :brand
      t.integer :units_of_sale, null: false
      t.belongs_to :category, index: true, null: false, default: 1
      t.integer :cents_price_per_unit, null: false, default: 0
      t.timestamps
    end
  end
end
