class CustomerPreferenceSerializer < ActiveModel::Serializer
  attributes :species, :breed, :age

  belongs_to :customer
end
