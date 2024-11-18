class AddPromotionable < ActiveRecord::Migration[8.0]
  def change
    add_reference :promotions, :promotionable, null: false, polymorphic: true, index: true
  end
end
