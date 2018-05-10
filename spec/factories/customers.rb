FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }

    factory :customer_with_adoption do
      after(:create) do |customer, evaluator|
        pet = create(:pet, adopted_by: customer.id)
        customer.pets << pet
      end
    end
  end
end
