class PetsController < ApplicationController
  include ResponseHelper
  include ExceptionHandler

  PERPAGE = 30

  def index
    page = (params['page'] || 1).to_i
    json_response(
      Pet.limit(PERPAGE).offset(skip(page, PERPAGE)),
      pagination(page, Pet.count, PERPAGE)
    )
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
