class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :name, null: false, default: ""
      t.boolean :is_invalid_flag, null: false, default: true

      t.timestamps
    end
  end
end
