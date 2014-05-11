class AdminController < ApplicationController

  def list_work
    @works = Work.all.sort{|x, y| y.id <=> x.id }
  end
end
