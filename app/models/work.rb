class Work < ActiveRecord::Base
  attr_accessible :title,:description, :filename, :finish_date, :status_work, :upload_date
  belongs_to :user
end
