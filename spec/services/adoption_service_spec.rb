require "rails_helper"

RSpec.describe AdoptionService, type: :service do
  describe "#adopt!" do
    let(:customer) { create(:customer) }

    it "returns true" do
      pet = create(:pet)
      expect(AdoptionService.new.adopt!(customer, pet)).to be_truthy
      expect(customer.reload.pets.count).to eq(1)
      expect(pet.reload.adopted_by).to eq(customer.id)
    end

    it "raise PetUnadoptableError" do
      pet = create(:unavailable_pet)
      expect {
        AdoptionService.new.adopt!(customer, pet)
      }.to raise_error(ApplicationError::PetUnadoptableError)
    end
  end
end
