module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: 'invalid params' }, {}, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: 'record not found' }, {}, :not_found)
    end

    rescue_from ApplicationError::PetUnadoptableError do |e|
      json_response({ message: 'pet unadoptable' }, {}, :bad_request)
    end
  end
end
