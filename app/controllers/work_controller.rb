class WorkController < ApplicationController
  before_filter :authenticate_user! ,:update_status

  def show
    @work = Work.find(params[:id])
  end

  def new
    @user = current_user
    @work = @user.works.new
    @last = @user.works.last if @user.works.last
    @l_works = @user.works.find_all_by_status_work ["finish","fail"]
    @l_work = @l_works.last
    @count = @user.works.find_all_by_status_work("processing").count
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
      @work.run_perl
      flash[:notice] = "Upload successful"
      save_pid @work
      redirect_to root_path
    else
      render :action => :new
    end
  end

  private
  def save_pid(work)
    path = work.get_full_path+'pid.txt'
    pid = 0
    File.open(path, "r").each_line do |line|
      pid = line
    end
    work.update_attributes(:pid =>pid)
  end

  def update_status
    @works = current_user.works.find_all_by_status_work("processing")
    @works.each do |w|
      statusD = w.get_update_status_work
      unless statusD == "processing"
        status_date = statusD.split("|")
        date = status_date[1]
        status = status_date[0]
        w.update_attributes(:status_work => status,:finish_date=> date)
      end

    end
  end


end
