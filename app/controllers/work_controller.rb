class WorkController < ApplicationController
  before_filter :authenticate_user!

  def show
    @work = Work.find(params[:id])
  end

  def new
    @user = current_user
    @work = @user.works.new
    @last = @user.works.last if @user.works.last
    @works = @user.works
    @count = @works.find_all_by_status_work("processing").count
    unless @count <=5
      flash[:error] = "You are processing program more than 5. Please wait."
    end

  end

  def create
    #render text: params[:work].inspect
    @work = current_user.works.new(params[:work])
    @works = current_user.works
    @count = @works.find_all_by_status_work("processing").count

    if @work.save
      flash[:notice] = "Upload successful"
      redirect_to root_path
    else
      render :action => :new
    end
  end
end
