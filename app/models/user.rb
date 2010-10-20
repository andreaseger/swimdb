class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # :confirmable
  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation

  field :username
  references_many :schedules
  references_many :comments

  validates_presence_of :username
  validates_uniqueness_of :username
  #validates_associated :schedules, :comments
end

