# frozen_string_literal: true

class Web::HomeController < ApplicationController
  def index
    @q = Bulletin.published.includes(:user).with_attached_image.ransack(params[:q])
    @bulletins = @q.result.order(updated_at: :desc).page(params[:page]).per(12)
  end
end
