# frozen_string_literal: true

class AdminPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, _)
    super
    @user = user
  end

  def user_admin?
    user&.admin
  end
end
