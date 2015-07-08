class Web::BaseController < ApplicationController
  layout 'web'

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render file: "public/404.html", status: 404
  end
end
