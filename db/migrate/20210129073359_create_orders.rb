class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false, default: ""
      t.string :postal_code, null: false, default: ""
      t.string :name, null: false, default: ""
      t.string :address, null: false, default: ""
      t.integer :postage, null: false, default: 800
      t.integer :settlement, null: false, default: 0
      t.integer :total_payment, null: false, default: ""
      t.integer :order_status, null: false, default: 0

      t.timestamps
    end
  end
end
