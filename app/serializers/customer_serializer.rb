class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :customer_preferences
end
