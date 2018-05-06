class CustomerPreference < ApplicationRecord
  belongs_to :customer

  validates_presence_of :species
  validates_inclusion_of :species, in: PET_SPECIES
  validates_numericality_of :age, only_integer: true, allow_nil: true
end
