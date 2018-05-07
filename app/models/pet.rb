class Pet < ApplicationRecord
  validates_presence_of :name, :species, :breed, :age
  validates_inclusion_of :species, in: PET_SPECIES
  validates_numericality_of :age, only_integer: true
end
