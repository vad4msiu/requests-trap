Rails.application.routes.draw do
  root :to => 'web/main#index'

  scope module: :web do
    controller :traps do
      match ':trap_id' => :capture, via: :all
    end

end
