require 'rails_helper'

RSpec.describe Adoption, type: :model do
  describe "associations" do
    it { should belong_to(:customer) }
    it { should belong_to(:pet) }
  end
end
