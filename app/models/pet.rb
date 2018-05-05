class Pet < ApplicationRecord
  validates_presence_of :name, :species
  validates_inclusion_of :species, in: PET_SPECIES
end
