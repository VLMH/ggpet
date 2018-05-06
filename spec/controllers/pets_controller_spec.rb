require 'rails_helper'

RSpec.describe PetsController, type: :controller do

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
