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

  def update_status
    Work.first.update_status
    #works = Work.find_all_by_status_work("processing")
    #works.each do |w|
    #  statusD = w.get_update_status_work
    #  unless statusD == "processing"
    #    status_date = statusD.split("|")
    #    date = status_date[1]
    #    status = status_date[0]
    #    w.update_attributes(:status_work => status, :finish_date => date)
    #    UserMailer.finished_work(w).deliver
    #  end
    #end
  end

end
