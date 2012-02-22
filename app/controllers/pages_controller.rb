class PagesController < ApplicationController
  #caches_page :index, :show, :article
  layout "pages"

  def index
    homepage
    default_menu_pages
    @page = Page.first_page
    check_404(@page)
  end

  def show
    homepage
    default_menu_pages
    @page = Page.find(:first, :conditions => ["permalink = ?", params[:permalink]])
    check_404(@page)
  end

  def article
    final_permalink = params[:category]+"/"+params[:article]
    @article = Article.find(:first, :conditions => ["final_permalink = ?",final_permalink])
    check_404(@article)
  end


  private
  def default_menu_pages
    @pages = Page.position_order(Menu.find(:first, :conditions => {:name => "default"}).id)
  end

  def check_404(page)
    render_404 if page.nil? # render_404 on application controller
  end

  def homepage
    @homepage = Page.first_page
  end

end

