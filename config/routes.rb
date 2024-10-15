Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope module: "api" do
    namespace :v1 do
      resources :jobs
      resources :geeks do
        get "readed/:geek_id", to: "geeks#readed_by_geek", on: :collection
        get "accepted/:geek_id", to: "geeks#accepted_applies", on: :collection
        get "applies/:geek_id", to: "geeks#geek_all_applies", on: :collection
        put "update_resume/:geek_id", to: "geeks#update_resume", on: :collection
      end
      resources :applies
      resources :companies do
        resources :jobs
      end
    end
  end

  match "*path", to: "application#catch_404", via: :all


  # Defines the root path route ("/")
  # root "posts#index"
end
