class ProcessController < ApplicationController
  before_filter :authenticate_user! , :update_status

  def finish
    @works = current_user.works.find_all_by_status_work ["done!","fail"]

    @work = @works.last
  end

  def going
    @works = current_user.works.find_all_by_status_work("processing")

  end

  def done
    @works = current_user.works.find_all_by_status_work("finish")
  end

  def fail
    @works = current_user.works.find_all_by_status_work("fail")
  end

end
