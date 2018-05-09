class AdoptionService
  def adopt!(customer, pet)
    raise ApplicationError::PetUnadoptableError unless (pet.adoptable?)

    ActiveRecord::Base.transaction do
      customer.pets << pet
      customer.save!

      pet.adoptor = customer
      pet.save!
    end
  end
end
