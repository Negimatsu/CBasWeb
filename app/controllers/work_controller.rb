class WorkController < ApplicationController
  before_filter :authenticate_user!

  def show
    @work = Work.find(params[:id])

  end

  def new
    @user = current_user
    @work = @user.works.new
    @last = @user.works.last
  end

  def create
    #render text: params[:work].inspect
    @work = current_user.works.new(params[:work])

    if @work.save
      redirect_to root_path
    else
      redirect_to contact_path, :alert => "Unable to create"
    end

  end
end
