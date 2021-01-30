class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :item_id, null: false, default: ""
      t.integer :quantity, null: false, default: 1
      t.integer :customer_id, null: false, default: ""
      t.integer :quantity, null: false, default: ""

      t.timestamps
    end
  end
end
