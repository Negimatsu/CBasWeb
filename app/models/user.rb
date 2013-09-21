class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me ,:profile_attributes

  has_many :works
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  before_create :set_default_role


  private

  def welcome_message
    UserMailer.welcome_email(self).deliver
  end

  def set_default_role
    self.add_role :user
  end

end
