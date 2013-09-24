class Work < ActiveRecord::Base
  attr_accessible :title,:description, :filename, :finish_date, :status_work,:is_bacteria, :upload_date
  belongs_to :user
  mount_uploader :filename, FastaUploader

  validates :title, :presence => true
  validates :filename, :presence => true
  after_save :run_perl


  def get_path
    self.filename.current_path.split('/')
  end

  def run_perl
    array_path = get_path[0..-2]
    path = array_path*"/"+'/'
    filename = get_path[-1]
    makefile_cmd = "mkdir #{path}conBlast"
    system makefile_cmd
    #perl_cmd = "perl /home/ongkrab/MyProjectCbas/Deverlopment/codePerl/ProjectMain.pl #{filename} #{path} #{self.is_bacteria} 1>#{path}pass.txt 2>#{path}err.txt &"
    perl_cmd = "perl #{ENV['PATH_PERL']} #{filename} #{path} #{self.is_bacteria} 1>#{path}pass.txt 2>#{path}err.txt &"
    p "#####################################################################################"
    #puts perl_cmd
    #self.save
    system perl_cmd
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

  def file_dir_or_symlink_exists?(path_to_file)
    File.exist?(path_to_file) || File.symlink?(path_to_file)
  end

end
