require "rails_helper"

RSpec.describe MatchingService, type: :service do
  describe "#match_all_customer_by_pet" do
    let(:pet) { build(:pet) }
    let(:matching) { MatchingService.new.match_all_customer_by_pet(pet) }

    it "returns no customers" do
      expect(matching.size).to eq(0)
    end

    it "returns a customer who like that breed" do
      preference = {
        pet.species => {
          breed: [pet.breed],
        }
      }
      customer = create(:customer, preferences: preference)

      expect(matching.size).to eq(1)
    end

    it "returns a customer who like that species" do
      preference = {
        pet.species => {}
      }
      customer = create(:customer, preferences: preference)

      expect(matching.size).to eq(1)
    end

    it "returns a customer who like any pets" do
      customer = create(:customer, preferences: nil)
      expect(matching.size).to eq(1)
    end

    it "returns a customer who like pets with specific age range" do
      customer = create(
        :customer,
        preference_age_min: pet.age,
        preference_age_max: pet.age
      )
      expect(matching.size).to eq(1)
    end

    it "returns no customers in specific age range" do
      customer = create(
        :customer,
        preference_age_min: pet.age + 1,
        preference_age_max: pet.age + 2
      )
      expect(matching.size).to eq(0)
    end

    it "returns all matched customers with age preference" do
      species = pet.species
      breed = pet.breed
      age = pet.age
      age_preference = {preference_age_min: age, preference_age_max: age}

      create(:customer, age_preference)
      create(:customer, age_preference.merge({preferences: {species => {}}}))
      create(:customer, age_preference.merge({preferences: {species => {breed: [breed]}}}))
      expect(matching.size).to eq(3)
    end
  end
end
