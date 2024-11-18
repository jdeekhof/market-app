class CreateCartsAndCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.timestamps
    end

    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :promotion, foreign_key: true
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
