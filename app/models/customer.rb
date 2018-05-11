class Customer < ApplicationRecord

  PREF_AGE_MIN = 0
  PREF_AGE_MAX = 500

  # associations
  has_many :adoptions
  has_many :pets, through: :adoptions

  # validations
  validates_presence_of :name

  # TODO validate preferences; only supported species; breed can be nil but cannot be empty

  # scopes
  default_scope { order(:id) }

  # like any pets
  scope :without_preferences, -> { where("customers.preferences is null") }

  # like specific species with any breeds
  scope :like_species, -> (species) do
    where("customers.preferences ? :species", species: species)
    .where.not("customers.preferences->:species ? 'breed'", {species: species})
  end

  # like specific breed
  scope :like_breed, -> (species, breed) do
    where("customers.preferences#>:path ? :breed", {path: "{#{species}, breed}", breed: breed})
  end

  # like pet in specific age range
  scope :like_age, -> (age) do
    where("customers.preference_age_min <= ?", age)
    .where("customers.preference_age_max >= ?", age)
  end

  # has no adoptions
  scope :no_adoptions, -> do
    left_outer_joins(:adoptions).where("adoptions.id is null").select("customers.*")
  end
end
