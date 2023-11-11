Rails.application.routes.draw do
  devise_for :users

  namespace :api, default: {format: :json} do
    namespace :v1 do
      resources :urls, only: [:create]
    end
  end
  get '/urls/:shortened_url', to: 'redirections#show', as: :shorten_url_redirect
end
