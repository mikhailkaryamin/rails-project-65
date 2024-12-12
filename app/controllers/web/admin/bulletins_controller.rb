# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, only: %i[publish reject archive]

  def index
    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.order(updated_at: :desc).page(params[:page])
  end

  def publish
    @bulletin.publish!

    if @bulletin.published?
      redirect_back_or_to admin_root_path, notice: t('.success')
    else
      redirect_back_or_to admin_root_path, notice: t('.fail')
    end
  end

  def reject
    @bulletin.reject!

    if @bulletin.published?
      redirect_back_or_to admin_root_path, notice: t('.success')
    else
      redirect_back_or_to admin_root_path, notice: t('.fail')
    end
  end

  def archive
    @bulletin.archive!

    if @bulletin.archived?
      redirect_back_or_to admin_root_path, notice: t('.success')
    else
      redirect_back_or_to admin_root_path, notice: t('.fail')
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end
end
