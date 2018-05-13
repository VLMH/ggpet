require 'pusher'

# A wrapper to external realtime service
class RealtimeMessager
  CHANNEL_MATCHING_PETS = 'matching-pets'
  EVENT_PET_CREATED = 'pet-created'

  def publish(channel, event, message)
    Pusher.trigger(channel, event, {
      message: message
    })
  end
end
