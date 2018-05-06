class PetsController < ApplicationController

  PERPAGE = 30

  def index
    page = (params['page'] || 1).to_i
    @pets = Pet.page(page).per(PERPAGE)
    json_response(
      @pets,
      pagination(@pets, PERPAGE)
    )
  end

  def show
    json_response(Pet.find(params['id']))
  end

  def create
    @pet = Pet.create!(pet_params)
    json_response(@pet, {}, :created)
  end

  private

  def pet_params
    params.permit(:name, :age, :species, :breed, :available_at)
  end
end
