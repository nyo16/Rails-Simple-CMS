class Admin::CategoriesController < ApplicationController

  layout "admin"
  before_filter :authenticate_user!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: "Category was successfully deleted."
  end

  def show
    @category = Category.find(params[:id])
  end

end

