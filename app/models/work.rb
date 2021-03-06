class Work < ActiveRecord::Base
  attr_accessible :title,:description, :filename, :finish_date, :status_work,:is_bacteria, :upload_date , :pid
  belongs_to :user
  mount_uploader :filename, FastaUploader

  validates :title, :presence => true
  validates :filename, :presence => true
  validates_inclusion_of :is_bacteria, :in => [true, false]
  #after_save :run_perl

  PERCENT_FILE = "Percentfile.txt"

  def update_status
    works = Work.find_all_by_status_work("processing")
    works.each do |w|
      statusD = w.get_update_status_work
      unless statusD == "processing"
        status_date = statusD.split("|")
        date = status_date[1]
        status = status_date[0]
        w.update_attributes(:status_work => status, :finish_date => date)
        UserMailer.finished_work(w).deliver
      end
    end
  end

  def get_is_bacteria
    if is_bacteria
      return "Yes"
    else
      return "No"
    end
  end

  def get_path
    self.filename.current_path.split('/')
  end

  def get_percent
    percent = get_full_path+"Percentfile.txt"
    percent_work = 0
    File.open(percent, "r").each_line do |line|
      eline = line.split("|")
      percent_work = eline[1]
    end
    percent_work
  end

  def percentfile_exist?
    file_dir_or_symlink_exists? get_full_path + PERCENT_FILE
  end

  def get_update_status_work
    status = "processing"
    unless is_running?
      path = get_full_path+"Percentfile.txt"
      finish = ""
      time = ""
      File.open(path, "r").each_line do |line|
        eline = line.split("|")
        finish = eline[0]
        time = eline[2]
      end
      if finish == "done!"
        status = "#{finish}|#{time}"
      else
        finish = "fail"
        status = "#{finish}|#{time}"
      end
    end

    status
  end

  def get_full_path
    array_path = get_path[0..-2]
    array_path*"/"+'/'
  end

  def run_perl
    array_path = get_path[0..-2]
    path = array_path*"/"+'/'
    filename = get_path[-1]
    makefile_cmd = "mkdir #{path}conBlast"
    system makefile_cmd
    perl_cmd = "perl #{ENV['PATH_PERL']} #{filename} #{path} #{self.is_bacteria} 1>#{path}pass.txt 2>#{path}err.txt &"
    p "#####################################################################################"
    puts perl_cmd
    system perl_cmd

    #unix_cmd = "ps -ef | tr -s ' ' |grep 'perl #{ENV['PATH_PERL']} #{filename} #{path}' |tail --lines=3 | head --lines=1 | cut -d ' ' -f 2 |tr -d '\n' > #{path}pid.txt"
    unix_cmd = "echo -n '#{filename} #{path} #{self.is_bacteria}' > #{path}pid.txt"
    p "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n#{unix_cmd}"
    system unix_cmd
  end

  def get_url_folder
    path = self.filename.url.split('/')
    path[0..-2]*"/"+'/'
  end

  def get_phylogeny
    get_url_folder+'treeprint.png'
  end

  def get_burst
    get_url_folder+'burstFromEburst.jnlp'
  end

  def get_cladogram
    get_url_folder+'treeCladogram.txt'
  end

  def get_allelic
    get_url_folder+'allelicProfile.txt'
  end

  def get_allelic_error
    get_url_folder+'errorAllelic.txt'
  end

  def get_allelic_user
    get_url_folder+'AllelicProfileForUser.txt'
  end

  def get_error_file
    get_url_folder+'err.txt'
  end

  def file_dir_or_symlink_exists?(path_to_file)
    File.exist?(path_to_file) || File.symlink?(path_to_file)
  end

  def is_running?
    unix_cmd = "ps -ef | tr -s ' ' | cut -d ' ' -f 10-12 | grep '#{self.pid}'"
    p unix_cmd
    run = system unix_cmd
    run
  end

end
