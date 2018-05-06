require 'rails_helper'

RSpec.describe PetsController, type: :controller do

  # get pet list
  shared_examples_for "get pet list" do |record_count, params, expected_size|
    it "return pet list" do
      create_list(:pet, record_count)
      get :index, params: params
      expect(response.status).to eq(200)
      expect(json_data.size).to eq(expected_size)
    end
  end

  describe "GET /v1/pets" do
    it_should_behave_like "get pet list", 0, {}, 0
    it_should_behave_like "get pet list", 1, {}, 1
    it_should_behave_like "get pet list", 10, {}, 10
    it_should_behave_like "get pet list", 100, {}, 30
    it_should_behave_like "get pet list", 100, {page: 1}, 30
    it_should_behave_like "get pet list", 100, {page: 4}, 10
  end

  # create pets
  describe "POST /v1/pets" do
    context "success" do
      let(:cat) do
        {
          name: "Bagel",
          age: 5,
          species: "cat",
          breed: "Aegean",
          available_at: Time.now.strftime("%F"),
        }
      end

      it "response status code 201" do
        post :create, params: cat
        expect(response.status).to eq(201)
        expect(Pet.count).to eq(1)
      end
    end

    context "fail" do
      it "response status code 422 for invalid params" do
        post :create
        expect(response.status).to eq(422)
      end
    end
  end

end
