class Admin
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # :confirmable
  devise :registerable,
         :database_authenticatable,
         :rememberable,
         :trackable,
         :validatable
         #:recoverable,
         #, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
end

