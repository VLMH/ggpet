class Customer < ApplicationRecord
  has_many :customer_preferences

  validates_presence_of :name
end
