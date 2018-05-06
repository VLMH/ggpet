class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :species, :breed, :age, :available_at

  def available_at
    object.available_at.strftime('%F')
  end
end
