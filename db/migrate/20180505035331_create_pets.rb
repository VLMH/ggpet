class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name, null: false
      t.integer :age, :unsigned => true
      t.string :species, null: false, default: ''
      t.string :breed, null: false, default: ''
      t.datetime :available_at

      t.timestamps
    end
    add_index :pets, :species
  end
end
