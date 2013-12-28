class AdminController < ApplicationController

  def list_work
    @works = Work.all
  end
end
