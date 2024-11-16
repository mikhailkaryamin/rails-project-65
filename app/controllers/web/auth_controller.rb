# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    user = SocialNetworkService.authenticate_user(auth)

    sign_in user

    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
