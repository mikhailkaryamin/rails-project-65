# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.order(created_at: :desc)
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find params[:id]
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: 'Категория была создано'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find params[:id]

    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: 'Category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find params[:id]

    @category&.destroy!

    redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
