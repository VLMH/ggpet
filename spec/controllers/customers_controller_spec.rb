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
      let(:params_name) { {name: "World"} }
      let(:params_pref) do
        {
          preferences: {
            "dog": {
              breed: ["poodle"],
              age_min: 2,
              age_max: 5,
            }
          }
        }
      end
      let(:params_age) do
        {
          preference_age_min: 1,
          preference_age_max: 3,
        }
      end
      let(:params) { params_name.merge(params_pref).merge(params_age) }

      it "creates a new Customer" do
        expect {
          post :create, params: params
        }.to change(Customer, :count).by(1)
      end

      it "renders a JSON response with the new customer" do
        post :create, params: params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        ["id", "name", "preferences", "preference_age_min", "preference_age_max"].each do |field|
          expect(json_data).to have_key(field)
        end
        expect(json_data["preferences"]).to have_key("dog")
      end

      it "create customer with no preferences" do
        post :create, params: params_name
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        ["id", "name", "preferences"].each do |field|
          expect(json_data).to have_key(field)
        end
        expect(json_data["preferences"]).to be_nil
      end
    end

    context "fail" do
      it "renders a JSON response with errors for the new customer" do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

end
