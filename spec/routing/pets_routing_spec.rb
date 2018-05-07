require "rails_helper"

RSpec.describe PetsController, type: :routing do
  describe "routing" do
    it { expect(:get => "/v1/pets").to route_to("pets#index") }
    it { expect(:get => "/v1/pets/123").to route_to(controller: "pets", action: "show", id: "123") }
    it { expect(:post => "/v1/pets").to route_to("pets#create") }
    it { expect(:get => "/v1/pets/123/matches").to route_to(controller: "pets", action: "matching", id: "123") }
  end
end
