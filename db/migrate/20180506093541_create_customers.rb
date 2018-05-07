class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.jsonb :preferences
      t.integer :preference_age_min, :unsigned => true, null: false, default: 0
      t.integer :preference_age_max, :unsigned => true, null: false, default: 500, comment: 'assume pets have max 500 age'

      t.timestamps
    end
    add_index :customers, :preferences, using: :gin
  end
end
