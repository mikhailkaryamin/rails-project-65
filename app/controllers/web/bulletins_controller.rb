# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :set_bulletin, only: %i[show]

    def index
      @bulletins = Bulletin.includes(:category, :creator).order(created_at: :desc)
    end

    def show
      @bulletin = Bulletin.find params[:id]
    end

    def new
      @bulletin = Bulletin.new
    end

    def edit
      @bulletin = Bulletin.find params[:id]
    end

    def create
      @bulletin = Bulletin.new(bulletin_params)
      @bulletin.creator = current_user

      if @bulletin.save
        redirect_to root_path, notice: "Объявление было создано"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @bulletin = Bulletin.find params[:id]

      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: 'Bulletin was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @bulletin = Bulletin.find params[:id]

      @bulletin&.destroy!

      redirect_to vehicles_url, notice: 'Bulletin was successfully destroyed.'
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end
  end
end
