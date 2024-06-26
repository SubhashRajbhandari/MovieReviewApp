




Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  namespace :v1 do
    resources :movies  do
      resources :reviews
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # post '/movies/:movie_id/reviews', to: 'movies#create_review'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
   root "movies#index"
   resources :movies do
    resources :reviews
end
end
