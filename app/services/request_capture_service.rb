class RequestCaptureService
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def perform
    trap = Trap.find_or_initialize_by(name: trap_id)
    trap.requests.new(
      remote_ip:      request.remote_ip,
      request_method: request.method,
      scheme:         request.scheme,
      query_string:   request.query_string,
      query_params:   request.query_parameters,
      cookies:        request.cookies,
      headers:        request_headers ,
      raw:            request_raw
    )

    trap.save
  end

  private

  def request_raw
    @request_raw ||= begin
      string = ""
      request_headers .each_pair { |k, v| string << "#{ k }: #{ v }\n" }
      string << "\n"
      string << request.raw_post
    end
  end

  def request_headers 
    @headers  ||= begin
      request.headers.env.select { |k, v|
        k.match(/^HTTP_/)
      }.reduce({}) { |memo, (k, v)|
        formated_key = k.sub('HTTP_', '').titleize.sub(' ', '-')
        memo[formated_key] = v
        memo
      }
    end
  end

  def trap_id
    @trap_id ||= request.params[:trap_id]
  end
end