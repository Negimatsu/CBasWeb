class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :occupation, :path_file
  belongs_to :user

end
