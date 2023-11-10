Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, default: {format: :json} do
    namespace :v1 do
      resources :urls, only: [:create]
      get '/urls/:shortened_url', to: 'urls#show'
    end
  end
end
