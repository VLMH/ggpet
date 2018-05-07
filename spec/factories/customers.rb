FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
  end

  factory :customer_with_pref do
    name { Faker::Name.name }
    preferences do
      {
        dog: {
          breed: [Faker::Dog.breed],
          age_min: rand(10),
          age_max: rand(10) + 10,
        }
      }
    end
  end
end
