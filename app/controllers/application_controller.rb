# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include AuthConcern
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from NotAuthenticatedError, with: :user_not_authenticated

  private

  def user_not_authorized
    flash[:warning] = t('user_not_authorized')
    redirect_to root_path
  end

  def user_not_authenticated
    flash[:warning] = t('user_not_authenticated')
    redirect_to root_path
  end
end
