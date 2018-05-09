class Customer < ApplicationRecord

  PREF_AGE_MIN = 0
  PREF_AGE_MAX = 500

  # associations
  has_many :adoptions
  has_many :pets, through: :adoptions

  # validations
  validates_presence_of :name

  # TODO validate preferences; only supported species; breed can be nil but cannot be empty

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
  scope :like_age, -> (age) do
    where("preference_age_min <= ?", age)
    .where("preference_age_max >= ?", age)
  end
end
