class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    if current_user.has_role? :admin
      users_path
    else
      program_path
    end
  end

end
