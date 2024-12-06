# frozen_string_literal: true

class Web::HomeController < ApplicationController
  def index
    @bulletins = Bulletin.published.includes(:category, :creator).order(created_at: :desc)
  end
end
