class User
  include MongoMapper::Document
  timestamps!
  plugin MongoMapper::Devise
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # :confirmable
  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation

  key :username, String, :required => true, :unique => true

  many :schedules
  validates_associated :schedules
  many :comments
  validates_associated :comments
end

