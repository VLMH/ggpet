class Customer < ApplicationRecord
  validates_presence_of :name

  # like any pets
  scope :without_preferences, -> { where("preferences is null") }

  # like specific species with any breeds
  scope :like_species, -> (species) do
    where("preferences ? :species", species: species)
    .where.not("preferences->'#{species}' ? 'breed'")
  end

  # like specific breed
  scope :like_breed, -> (species, breed) do
    where("preferences#>'{#{species}, breed}' ? '#{breed}'")
  end
end
