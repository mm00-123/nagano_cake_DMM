# frozen_string_literal: true

class DeviseCreateCustomers < ActiveRecord::Migration[5.2]
   def change

    create_table :customers do |t|

      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :last_name,        null: false, default: ""
      t.string :first_name,         null: false, default: ""
      t.string :last_name_kana,   null: false, default: ""
      t.string :first_name_kana,    null: false, default: ""
      t.string :postal_code,        null: false, default: ""
      t.string :address,            null: false, default: ""
      t.string :telephone_number,       null: false, default: ""
      t.boolean :is_active, null: false, default: true


      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at


      t.timestamps null: false
    end

    add_index :customers, :email,                unique: true
    add_index :customers, :reset_password_token, unique: true

   end
end
