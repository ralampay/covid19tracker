class ApplicationController < ActionController::Base
  def authenticate_admin!
    if user_signed_in? and !current_user.admin?
      redirect_to root_path
    end
  end

  def authenticate_active!
    if user_signed_in? and !current_user.is_active
      redirect_to root_path
    end
  end

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
end
