class MatchingService
  def match_all_customer_by_pet(pet)
    Customer
      .without_preferences
      .or(Customer.like_species(pet.species))
      .or(Customer.like_breed(pet.species, pet.breed))
  end
end
