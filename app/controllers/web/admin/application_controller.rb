# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :check_if_admin

  private

  def check_if_admin
    return if current_user&.admin?

    redirect_to root_path
  end
end
