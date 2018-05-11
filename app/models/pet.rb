class Pet < ApplicationRecord
  # associations
  has_many :adoptions
  belongs_to :adoptor, foreign_key: :adopted_by, class_name: "Customer", optional: true

  # validations
  validates_presence_of :name, :species, :breed, :age
  validates_inclusion_of :species, in: PET_SPECIES
  validates_numericality_of :age, only_integer: true

  # scopes
  default_scope { order(:id) }
  scope :available, -> { where("pets.available_at <= ?", Time.now.strftime('%F'))}
  scope :adoptable, -> { available.where("pets.adopted_by is null")}

  def adoptable?
    available? && !adopted_by
  end

  def available?
    available_at <= Time.now
  end
end
