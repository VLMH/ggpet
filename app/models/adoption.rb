class Adoption < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
end
