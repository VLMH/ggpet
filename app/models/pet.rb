class Pet < ApplicationRecord
  # validations
  validates_presence_of :name, :species, :breed, :age
  validates_inclusion_of :species, in: PET_SPECIES
  validates_numericality_of :age, only_integer: true

  # scopes
  scope :available, -> { where("available_at <= ?", Time.now.strftime('%F'))}
end
