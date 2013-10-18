class ProcessController < ApplicationController
  before_filter :update_status

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

  private
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
