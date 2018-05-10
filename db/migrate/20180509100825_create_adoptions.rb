class CreateAdoptions < ActiveRecord::Migration[5.2]
  def change
    create_table :adoptions do |t|
      t.references :customer, foreign_key: true
      t.references :pet, foreign_key: true
      t.integer :status, limit: 2, null: false, default: 1, :unsigned => true

      t.timestamps
    end
    add_index :adoptions, [:customer_id, :pet_id], unique: true
  end
end
