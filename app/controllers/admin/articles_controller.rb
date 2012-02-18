class Admin::ArticlesController < ApplicationController
  layout :admin_Article_layout
  before_filter :authenticate_user!

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to admin_category_path(@article.category), notice: 'Article was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def ajax_edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to admin_category_path(@article.category), notice: 'Article was successfully updated.'
    else
      render action: "edit"
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_category_path(@article.category), notice: "Article was successfully deleted."
  end

  private
    def admin_Article_layout
      case action_name
      when "show"
        "Articles"
      else
        "admin"
      end
    end
end

