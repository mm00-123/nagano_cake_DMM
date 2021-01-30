class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id, null: false, default: ""
      t.integer :item_id, null: false, default: ""
      t.integer :tax_included_price, null: false, default: ""
      t.integer :quantity, null: false, default: 1
      t.integer :production_status, null: false, default: 0

      t.timestamps
    end
  end
end
