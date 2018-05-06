module ControllerSpecHelper
  def json_body
    JSON.parse(response.body)
  end

  def json_data
    json_body['data'] || {}
  end

  def json_meta
    json_body['meta'] || {}
  end
end
