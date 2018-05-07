class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :preferences
end
