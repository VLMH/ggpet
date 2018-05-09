FactoryBot.define do
  factory :pet do
    name { Faker::Name.name }
    age { rand(100) }
    species { 'dog' }
    breed { Faker::Dog.breed }
    available_at { Time.now.strftime("%F") }

    factory :unavailable_pet do
      available_at { (Time.now + 1.day).strftime("%F") }
    end

    factory :adopted_pet do
      association :adoptor, factory: :customer
    end
  end
end
