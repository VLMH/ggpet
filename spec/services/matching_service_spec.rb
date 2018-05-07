require "rails_helper"

RSpec.describe MatchingService, type: :service do
  describe "#match_all_customer_by_pet" do
    let(:pet) { build(:pet) }
    let(:matching) { MatchingService.new.match_all_customer_by_pet(pet) }

    it "returns no customers" do
      expect(matching.size).to eq(0)
    end

    it "returns a customer" do
      preference = {
        pet.species => {
          breed: [pet.breed],
        }
      }
      customer = create(:customer, preferences: preference)

      expect(matching.size).to eq(1)
    end
  end
end
