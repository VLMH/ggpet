require 'pusher'

# A wrapper to external realtime service
class RealtimeMessager
  CHANNEL_CUSTOMER_LIST = 'customer-list'
  EVENT_CUSTOMER_CREATED = 'customer-created'

  def publish(channel, event, message)
    Pusher.trigger(channel, event, {
      message: message
    })
  end
end
