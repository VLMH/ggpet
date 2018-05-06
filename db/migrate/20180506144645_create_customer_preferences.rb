class CreateCustomerPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_preferences do |t|
      t.references :customer, foreign_key: true, index: true
      t.string :species, null: false, default: ''
      t.string :breed, null: false, default: ''
      t.integer :age, unsigned: true

      t.timestamps
    end
  end
end
