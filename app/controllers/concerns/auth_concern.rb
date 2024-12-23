# frozen_string_literal: true

module AuthConcern
  extend ActiveSupport::Concern

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def signed_in?
    current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  class NotAuthenticatedError < StandardError; end

  def authenticate_user!
    raise NotAuthenticatedError unless signed_in?
  end
end
