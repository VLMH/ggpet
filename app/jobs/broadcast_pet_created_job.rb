class BroadcastPetCreatedJob < ApplicationJob
  queue_as :default

  def perform(pet)
    message = {
      pet: ActiveModelSerializers::SerializableResource.new(pet).as_json,
      matched_customer_ids: MatchingService.new.match_all_customer_by_pet(pet).pluck(:id),
    }

    RealtimeMessager.new.publish(
      RealtimeMessager::CHANNEL_MATCHING_PETS,
      RealtimeMessager::EVENT_PET_CREATED,
      message
    )
  end
end
