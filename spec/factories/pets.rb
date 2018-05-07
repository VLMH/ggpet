FactoryBot.define do
  factory :pet do
    name { Faker::Name.name }
    age { rand(100) }
    species { 'dog' }
    breed { Faker::Dog.breed }
    available_at { Time.now.strftime("%F") }
  end
end
