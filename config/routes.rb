Rails.application.routes.draw do
  namespace :api, default: {format: :json} do
    namespace :v1 do
      resources :urls, only: [:create]
    end
  end
  get '/urls/:shortened_url', to: 'redirections#show', as: :shorten_url_redirect
  devise_for :users, controllers: {
    registrations: "registrations",
  }
  devise_scope :user do
    root to: 'registrations#new'
  end
end
