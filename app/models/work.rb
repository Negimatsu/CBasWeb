class Work < ActiveRecord::Base
  attr_accessible :title,:description, :filename, :finish_date, :status_work, :upload_date
  belongs_to :user
  mount_uploader :filename, FastaUploader

  validates :title, :presence => true
  validates :filename, :presence => true

  def get_path
    self.filename.url
  end

  def run_perl
    perl_cmd = Escape.shell_command(['perl', "#{Rails_root}/app/assets/perlscript/ProjectMain.pl",self.filename ,]).to_s
    system perl_cmd
  end
end
