class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :preferences, :preference_age_min, :preference_age_max, :pets

  has_many :pets
end
