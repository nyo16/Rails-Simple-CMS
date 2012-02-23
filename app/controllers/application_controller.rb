class ApplicationController < ActionController::Base
  protect_from_forgery
  #rescue_from Exception, :with => :render_404

  # Devise redirects
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      admin_pages_path
    else
      super
    end
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    render_404
  end

  protected


    def ckeditor_authenticate
      authorize! action_name, @asset
    end

end

