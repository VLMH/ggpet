class Customer < ApplicationRecord

  PREF_AGE_MIN = 0
  PREF_AGE_MAX = 500

  validates_presence_of :name

  # like any pets
  scope :without_preferences, -> { where("preferences is null") }

  # like specific species with any breeds
  scope :like_species, -> (species) do
    where("preferences ? :species", species: species)
    .where.not("preferences->:species ? 'breed'", {species: species})
  end

  # like specific breed
  scope :like_breed, -> (species, breed) do
    where("preferences#>:path ? :breed", {path: "{#{species}, breed}", breed: breed})
  end

  # like pet in specific age range
  scope :like_age_between, -> (min, max) do
    where("preference_age_min >= ?", min)
    .where("preference_age_max <= ?", max)
  end
end
