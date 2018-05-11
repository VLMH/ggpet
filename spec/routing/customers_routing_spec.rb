require "rails_helper"

RSpec.describe CustomersController, type: :routing do
  describe "routing" do
    it { expect(:get => "/v1/customers").to route_to("customers#index") }
    it { expect(:get => "/v1/customers/123").to route_to(controller: "customers", action: "show", id: "123") }
    it { expect(:post => "/v1/customers").to route_to("customers#create") }
    it { expect(:get => "/v1/customers/123/matches").to route_to(controller: "customers", action: "matching", id: "123") }
    it { expect(:post => "/v1/customers/123/adoptions").to route_to(controller: "customers", action: "adopt", id: "123") }
  end
end
