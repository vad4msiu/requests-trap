class PublishService
  attr_reader :request

  def self.channel_name_for_trap(trap)
    "/traps/#{ trap.id }/requests"
  end

  def initialize(request)
    @request = request
  end

  def perform
    $pubnub.publish(channel: channel_name, message: message) do |envelope|
      puts "channel: #{ envelope.channel } msg: #{ envelope.message }"
    end
  end

  private

  def serialized_request
    query_params = ApplicationController.helpers.simple_hash_format(request.query_params)
    headers      = ApplicationController.helpers.simple_hash_format(request.headers)
    raw          = ApplicationController.helpers.simple_format(request.raw)

    {
      id:             request.id,
      created_at:     request.created_at.strftime("%T %D"),
      remote_ip:      request.remote_ip,
      request_method: request.request_method,
      scheme:         request.scheme,
      query_string:   request.query_string,
      query_params:   query_params,
      headers:        headers,
      raw:            raw,
      trap:           { id: request.trap_id },
    }
  end

  def message
    { request: serialized_request }
  end

  def channel_name
    self.class.channel_name_for_trap(request.trap)
  end
end