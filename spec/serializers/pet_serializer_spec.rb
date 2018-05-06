require 'rails_helper'

RSpec.describe PetSerializer, type: :serializer do

  def serialize(pet)
    options = { serializer: PetSerializer, root: :root }
    ActiveModelSerializers::SerializableResource.new(pet, options).as_json[:root]
  end

  it "serialize to json" do
    pet = build(:pet)
    expect(serialize(pet)).to have_key(:id)
  end

  it "no available_at" do
    pet = build(:pet, available_at: nil)
    expect(serialize(pet)).to include(available_at: nil)
  end
end
