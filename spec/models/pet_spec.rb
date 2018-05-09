require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "associations" do
    it { should have_many(:adoptions) }
    it { should belong_to(:adoptor) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:species) }
    it { should validate_presence_of(:breed) }
    it { should validate_presence_of(:age) }
    it { should validate_inclusion_of(:species).in_array(PET_SPECIES) }
    it { should validate_numericality_of(:age) }
  end

  describe "scopes" do
    describe "#available" do
      before(:each) do
        create(:pet)
        create(:pet, available_at: (Time.now + 1.day).strftime('%F'))
      end

      it { expect(Pet.available.count).to eq(1) }
    end
  end

  describe "#adoptable?" do
    it { expect(build(:pet).adoptable?).to be_truthy }
    it { expect(build(:unavailable_pet).adoptable?).to be_falsey }
    it { expect(build(:adopted_pet).adoptable?).to be_falsey }
  end

  describe "#available?" do
    it { expect(build(:pet).available?).to be_truthy }
    it { expect(build(:unavailable_pet).available?).to be_falsey }
  end
end
