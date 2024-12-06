# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post '/auth/:provider', to: 'auth#request', as: :auth_request
    get '/auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    get 'profile', to: 'profile#index'

    match '/403', to: 'errors#forbidden', via: :all
    match '/404', to: 'errors#not_found', via: :all
    match '/500', to: 'errors#server_error', via: :all
  end

  scope module: :web do
    root 'home#index'

    resource :session, only: %i[destroy]
    resources :bulletins do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace :admin do
      root 'home#index'

      resources :bulletins do
        member do
          patch :publish
          patch :archive
          patch :reject
          patch :to_moderate
        end
      end

      resources :categories
    end
  end
end
