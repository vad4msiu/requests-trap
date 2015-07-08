Rails.application.routes.draw do
  root :to => 'web/main#index'

  scope module: :web do
    controller :traps do
      match '/:trap_id' => :capture, via: :all
    end

    controller :requests do
      get '/:trap_id/requests' => :index, as: 'requests'
      get '/:trap_id/requests/:id' => :show, as: 'request'
    end
  end
end
