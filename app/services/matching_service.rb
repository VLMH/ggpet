class MatchingService
  def match_all_customer_by_pet(pet)
    Customer
      .like_age(pet.age).without_preferences
      .or(Customer.like_age(pet.age).like_species(pet.species))
      .or(Customer.like_age(pet.age).like_breed(pet.species, pet.breed))
  end
end
