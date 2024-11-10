# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post '/auth/:provider', to: 'auth#request', as: :auth_request
    get '/auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    match '/403', to: 'errors#forbidden', via: :all
    match '/404', to: 'errors#not_found', via: :all
    match '/500', to: 'errors#server_error', via: :all
  end

  scope module: :web do
    root 'home#index'

    resource :session, only: %i[destroy]
  end
end
