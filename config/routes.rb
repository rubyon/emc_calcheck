Rails.application.routes.draw do
  resources :heat_value_predictions
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  resources :elements
  resources :formulas
  resources :temp_elements
  resources :cal_marks

  get "/boxes/download", to: "boxes#download"
  get "/boxes_cal", to: "boxes#boxes_cal"
  get "/boxes_update", to: "boxes#boxes_update"
  get "/boxes_update_ok", to: "boxes#boxes_update_ok"
  post "/boxes_cal_save", to: "boxes#boxes_cal_save"
  resources :boxes

  get "/cctv", to: "home#cctv"
  get "/temperatures", to: "temperatures#index"
  get "/temperatures/download", to: "temperatures#download"

  post "/api/calcheck", to: "api#calcheck"
  get "/api/burned", to: "api#burned"

  post "/temp_elements/checked", to: "temp_elements#checked"
  post "/cal_marks/checked", to: "cal_marks#checked"

  post 'restart_service', to: 'api#restart_service'
end
