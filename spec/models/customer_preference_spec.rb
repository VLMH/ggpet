require 'rails_helper'

RSpec.describe CustomerPreference, type: :model do
  context "validations" do
    it { should validate_presence_of(:species) }
    it { should validate_inclusion_of(:species).in_array(PET_SPECIES) }
    it { should validate_numericality_of(:age) }
    end

  context "associations" do
    it { should belong_to(:customer) }
  end
end