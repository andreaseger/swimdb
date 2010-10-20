class User
  include MongoMapper::Document
  timestamps!
  plugin MongoMapper::Devise
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # :confirmable
  devise  :registerable,
          :database_authenticatable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable,
          :omniauthable
          #, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation

  key :username, String, :required => true, :unique => true

  many :schedules
  validates_associated :schedules
  many :comments
  validates_associated :comments
#  many :authentications
#  validates_associated :authentications

  class User < ActiveRecord::Base
    def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"]
          user.email = data["email"]
          debugger
        end
      end
    end
  end



#  key :image, String
#  def apply_omniauth(omniauth)
#    self.username = omniauth['user_info']['name'] if username.blank?
#    self.email = omniauth['user_info']['email'] if email.blank?
#    self.image = omniauth['user_info']['image'] if image.blank?
#    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
#  end
#
#  def password_required?
#    (authentications.empty? || !password.blank?) && super
#  end
#
end

