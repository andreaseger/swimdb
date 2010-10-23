class User
  include MongoMapper::Document
  timestamps!
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
  many :authentications, :dependent => :destroy
  validates_associated :authentications

  def self.new_with_session(params, session)
    super.tap do |user|
      debugger
      if data = session["devise.facebook_data"]
        user.authentications.build(:uid => data["uid"],:provider => data["provider"])
        user.email = data["extra"]["user_hash"]["email"]
        if data["user_info"]["nickname"] == ""
          user.username = data["extra"]["user_hash"]["name"]
        else
          user.username = data["user_info"]["nickname"]
        end
      end
    end
  end

  def self.find_for_oauth(omniauth, user)
    auth = Authentication.find_by_uid_and_provider(omniauth[:uid], omniauth[:provider])
    if user
      # the user wants to add fb to his account
      if auth
        return user if auth.user == user
        #TODO raise DuplicateOAuth
      else
        user.authentications.create!(:uid => omniauth[:uid],:provider => omniauth[:provider])
      end
    elsif auth
      # return the user
      auth.user
    else
      # not in db yet, user not logged in
      user = User.new()
    end
  end
end

