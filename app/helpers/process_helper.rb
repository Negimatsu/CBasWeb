module ProcessHelper
  def active? work, point

    if work.status_work == "done!"
      p "#################################################################"
      p work.get_percent
      if point == work.get_percent.to_i
        return "active complete"
      end
    elsif work.status_work == "processing"
      if point == work.get_percent.to_i
        return "active"
      end
    elsif work.status_work == "fail"
      if point == work.get_percent.to_i
        return "fail"
      end
    end
    ""
  end
end