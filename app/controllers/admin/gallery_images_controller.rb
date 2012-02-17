class Admin::GalleryImagesController < ApplicationController

  def create
    newparams = coerce(params)
    @upload = GalleryImage.new(newparams[:gallery_image])
    if @upload.save
      respond_to do |format|
        #format.html {redirect_to @upload.gallery}
        format.json {render :json => { :result => 'success', :upload => admin_gallery_image_path(@upload) } }
      end
    else
      respond_to do |format|
        format.json {render :json => { :result => 'failed' } }
      end
    end
  end

  def destroy
    @upload = GalleryImage.find(params[:id])
    if @upload.destroy
      render :text => "1"
    elsif
      render :text => "Error: image was not deleted"
    end
  end

  def show
    @upload = GalleryImage.find(params[:id], :include => :gallery)
    @total_uploads = GalleryImage.find(:all, :conditions => { :gallery_id => @upload.gallery_id})
  end

  private
  def coerce(params)
    if params[:gallery_image].nil?
      h = Hash.new
      h[:gallery_image] = Hash.new
      h[:gallery_image][:gallery_id] = params[:gallery_id]
      h[:gallery_image][:image] = params[:Filedata]
      h[:gallery_image][:image].content_type = MIME::Types.type_for(h[:gallery_image][:image].original_filename).first.to_s
      h
    else
      params
    end
  end
end

