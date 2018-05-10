class MatchingService
  def match_all_customer_by_pet(pet)
    Customer
      .no_adoptions.like_age(pet.age).without_preferences
      .or(Customer.no_adoptions.like_age(pet.age).like_species(pet.species))
      .or(Customer.no_adoptions.like_age(pet.age).like_breed(pet.species, pet.breed))
  end

  def match_all_pet_by_customer(customer)
    if (customer.preferences.nil?)
      return Pet.adoptable.where(age: customer.preference_age_min..customer.preference_age_max)
    end

    preferences = customer.preferences.clone

    # first preference
    first_species, first_species_pref = preferences.shift
    query = Pet.adoptable
      .where(age: customer.preference_age_min..customer.preference_age_max)
      .where(species: first_species)

    if first_species_pref['breed']
      query = query.where(breed: first_species_pref['breed'])
    end

    # remaining preferences
    final_query = preferences.reduce(query) do |carry_query, (species, species_pref)|
      q = Pet.adoptable
        .where(age: customer.preference_age_min..customer.preference_age_max)
        .where(species: species)

      if species_pref['breed']
        q = q.where(breed: species_pref['breed'])
      end
    
      carry_query.or(q)
    end

    final_query
  end
end
