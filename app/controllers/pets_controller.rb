class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :matching]

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
    json_response(@pet)
  end

  def create
    @pet = Pet.create!(pet_params)
    BroadcastNewPetMatchingJob.perform_later @pet
    json_response(@pet, {}, :created)
  end

  def matching
    json_response(MatchingService.new.match_all_customer_by_pet(@pet))
  end

  private

  def pet_params
    params[:available_at] ||= Time.now.strftime("%F")
    params.permit(:name, :age, :species, :breed, :available_at)
  end

  def set_pet
    @pet = Pet.find(params['id'])
  end
end
