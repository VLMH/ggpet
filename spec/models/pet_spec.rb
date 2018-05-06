require 'rails_helper'

RSpec.describe Pet, type: :model do
  # validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:species) }
  it { should validate_inclusion_of(:species).in_array(PET_SPECIES) }
  it { should validate_numericality_of(:age) }
end
