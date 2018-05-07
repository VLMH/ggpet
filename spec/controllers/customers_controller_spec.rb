require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  # Get customer list
  shared_examples_for "get customer list" do |record_count, params, expected_size|
    it "return customer list" do
      create_list(:customer, record_count)
      get :index, params: params
      expect(response.status).to eq(200)
      expect(json_data.size).to eq(expected_size)
    end
  end

  describe "GET /v1/customers" do
    it_should_behave_like "get customer list", 0, {}, 0
    it_should_behave_like "get customer list", 1, {}, 1
    it_should_behave_like "get customer list", 10, {}, 10
    it_should_behave_like "get customer list", 100, {}, 30
    it_should_behave_like "get customer list", 100, {page: 1}, 30
    it_should_behave_like "get customer list", 100, {page: 4}, 10
  end

  # Get customer details
  describe "GET /v1/customers/:id" do
    context "success" do
      let(:customer) { create(:customer) }

      it "return customer details" do
        get :show, params: {id: customer.id}
        expect(response).to have_http_status(200)
        expect(json_data).to include("id" => customer.id)
      end
    end

    context "fail" do
      it "return 404 not found" do
        get :show, params: {id: 999}
        expect(response).to have_http_status(404)
      end
    end
  end

  # Create customer
  describe "POST /v1/customers" do
    context "success" do
      let(:params) do
        {
          name: "World",
          species: "fish",
          breed: "gold fish",
          age: 0
        }
      end

      it "creates a new Customer" do
        expect {
          post :create, params: params
        }.to change(Customer, :count).by(1)
      end

      it "renders a JSON response with the new customer" do
        post :create, params: params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(json_data).to have_key("id")
      end
    end

    context "fail" do
      it "renders a JSON response with errors for the new customer" do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

      it "invalid preference params" do
        post :create, params: { name: "Victor" }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

end
