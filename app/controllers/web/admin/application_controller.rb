# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :check_if_admin

  after_action :verify_authorized

  def check_if_admin
    authorize :admin, :user_admin?
  end
end
