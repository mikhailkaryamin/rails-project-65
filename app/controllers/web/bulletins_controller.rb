# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_bulletin, only: %i[show edit update archive to_moderate]

  def index
    @q = Bulletin.published.includes(:user).with_attached_image.ransack(params[:q])
    @bulletins = @q.result.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def show
    authorize @bulletin
  end

  def new
    @bulletin = current_user.bulletins.build
    authorize @bulletin
  end

  def edit
    authorize @bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    authorize @bulletin

    @bulletin.archive!

    if @bulletin.archived?
      redirect_back_or_to profile_path, notice: t('.success')
    else
      redirect_back_or_to profile_path, notice: t('.fail')
    end
  end

  def to_moderate
    authorize @bulletin

    @bulletin.to_moderate!

    if @bulletin.under_moderation?
      redirect_back_or_to profile_path, notice: t('.success')
    else
      redirect_back_or_to profile_path, notice: t('.fail')
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
