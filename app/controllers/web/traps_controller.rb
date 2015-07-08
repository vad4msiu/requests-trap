class Web::TrapsController < Web::BaseController
  skip_before_action :verify_authenticity_token, only: [:capture]

  def capture
    service = RequestCaptureService.new(request)

    if service.perform
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end
  end
end