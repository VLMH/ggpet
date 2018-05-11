class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :species, :breed, :age, :available_at

  belongs_to :adoptor

  def available_at
    object.available_at ? object.available_at.strftime('%F') : nil
  end
end
