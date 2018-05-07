require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "scopes" do
    before(:each) do
      Rails.application.load_seed
    end

    context "#without_preferences" do
      it "returns 1 customer" do
        customers = Customer.without_preferences
        expect(customers.size).to eq(1)
        expect(customers.first.preferences).to be_nil
      end
    end

    context "#like_species" do
      it "returns a bird lover" do
        customers = Customer.like_species("bird")
        expect(customers.size).to eq(1)
        expect(customers.first.preferences).to have_key("bird")
      end

      it "returns dog lovers" do
        customers = Customer.like_species("dog")
        expect(customers.size).to eq(3)
      end
    end

    context "#like_breed" do
      it "returns abyssinians lover" do
        customers = Customer.like_breed("cat", "abyssinians")
        expect(customers.size).to eq(1)
        expect(customers.first.preferences["cat"]).to include("breed" => ["abyssinians"])
      end
    end
  end
end
