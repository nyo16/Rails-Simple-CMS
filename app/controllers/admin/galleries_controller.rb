class Admin::GalleriesController < ApplicationController

  layout "admin"
  before_filter :authenticate_user!

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      redirect_to admin_gallery_path(@gallery), notice: 'Gallery was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @gallery = Gallery.find(params[:id])
    @gallery.gallery_images.build
  end

  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      redirect_to admin_gallery_path(@gallery), notice: 'Gallery was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    redirect_to admin_galleries_path, notice: "Gallery was successfully deleted."
  end

  def show
    @gallery = Gallery.find(params[:id], :include => :gallery_images)
  end


end

