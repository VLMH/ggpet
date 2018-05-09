class AddAdoptedByToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :adopted_by, :bigint
    add_index :pets, :adopted_by
  end
end
