class PetsController < ApplicationController
  include ExceptionHandler

  def create
    @pet = Pet.create!(pet_params)
    render json: @pet, status: :created
  end

  private

  def pet_params
    params.permit(:name, :age, :species, :breed, :available_at)
  end
end
