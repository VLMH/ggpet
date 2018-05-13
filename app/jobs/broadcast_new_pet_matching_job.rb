class BroadcastNewPetMatchingJob < ApplicationJob
  queue_as :default

  def perform(pet)
    message = ActiveModelSerializers::SerializableResource.new(pet).as_json.merge({
      matched_customer_ids: MatchingService.new.match_all_customer_by_pet(pet).pluck(:id),
    })

    RealtimeMessager.new.publish(
      RealtimeMessager::CHANNEL_MATCHING_PETS,
      RealtimeMessager::EVENT_PET_CREATED,
      message
    )
  end
end
