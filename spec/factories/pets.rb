FactoryBot.define do
  factory :pet do
    name { Faker::Name.name }
    age { 2 }
    species { 'dog' }
    breed { 'poodle' }
    available_at { Time.now }
  end
end
