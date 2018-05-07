class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.jsonb :preferences, null: false, default: []

      t.timestamps
    end
    add_index :customers, :preferences, using: :gin
  end
end
