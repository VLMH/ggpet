require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "associations" do
    it { should have_many(:adoptions) }
    it { should have_many(:pets).through(:adoptions) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "scopes" do
    context "#without_preferences" do
      before(:each) do
        Rails.application.load_seed
      end

      it "returns 1 customer" do
        customers = Customer.without_preferences
        expect(customers.size).to eq(1)
        expect(customers.first.preferences).to be_nil
      end
    end

    context "#like_species" do
      before(:each) do
        Rails.application.load_seed
      end

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
      before(:each) do
        Rails.application.load_seed
      end

      it "returns abyssinians lover" do
        customers = Customer.like_breed("cat", "abyssinians")
        expect(customers.size).to eq(1)
        expect(customers.first.preferences["cat"]).to include("breed" => ["abyssinians"])
      end
    end

    context "#like_age" do
      before(:each) do
        create(:customer, preference_age_min: 10, preference_age_max: 20)
      end

      it { expect(Customer.like_age(9).count).to eq(0) }
      it { expect(Customer.like_age(10).count).to eq(1) }
      it { expect(Customer.like_age(11).count).to eq(1) }
      it { expect(Customer.like_age(19).count).to eq(1) }
      it { expect(Customer.like_age(20).count).to eq(1) }
      it { expect(Customer.like_age(21).count).to eq(0) }
    end
  end
end
