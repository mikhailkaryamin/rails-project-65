# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, only: %i[publish reject archive]

  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  def publish
    @bulletin.publish!

    if @bulletin.published?
      redirect_back_or_to admin_root_path, notice: 'Bulletin was successfully published.'
    else
      redirect_back_or_to admin_root_path, notice: "Bulletin wasn't successfully created."
    end
  end

  def reject
    @bulletin.reject!

    if @bulletin.published?
      redirect_back_or_to admin_root_path, notice: 'Bulletin was successfully published.'
    else
      redirect_back_or_to admin_root_path, notice: "Bulletin wasn't successfully created."
    end
  end

  def archive
    @bulletin.archive!

    if @bulletin.archived?
      redirect_back_or_to admin_root_path, notice: 'Bulletin was successfully archived.'
    else
      redirect_back_or_to admin_root_path, notice: "Bulletin wasn't successfully archived."
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end
end
