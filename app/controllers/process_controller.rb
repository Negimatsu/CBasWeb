class ProcessController < ApplicationController
  def finish
    @works = Work.find_all_by_status_work("finish")
    @work = @works.last
  end

  def going
    @works = Work.find_all_by_status_work("processing")
  end

  def done
    @works = Work.find_all_by_status_work("finish")
  end

  def fail
  end
end
