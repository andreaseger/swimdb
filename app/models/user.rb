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
          :omniauthable,
          :authentication_keys => [:username]
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

  after_destroy :clear_authentications

  def clear_authentications
    debugger
  end


  def self.find_for_oauth(omniauth, user)
    auth = Authentication.find_by_uid_and_provider(omniauth["uid"], omniauth["provider"])
    if user
      # the user wants to add fb to his account
      if auth
        return user if auth.user == user
        raise 'Account already linked to a user'
      else
        user.authentications.create!(:uid => omniauth["uid"],:provider => omniauth["provider"])
      end
    elsif auth
      # return the user
      auth.user
    else
      # not in db yet, try to create a new user on the fly - no password
      user = case omniauth["provider"]
      when "facebook"
        create_new_fb_user(omniauth)
      when "twitter"
        User.new
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      #case facebook
      if data = session["devise.facebook_data"]
        user.authentications.build(:uid => data["uid"],:provider => data["provider"])
        user.email = data["extra"]["user_hash"]["email"] unless user.email || user.email == ""
        unless user.username || user.username = ""
            user.username = data["extra"]["user_hash"]["name"]
        end
      elsif data = session["devise.twitter_data"]
        user.authentications.build(:uid => data["uid"],:provider => data["provider"])
        user.email = data["extra"]["user_hash"]["email"] unless user.email || user.email == ""
        unless user.username || user.username = ""
            user.username = data["extra"]["user_hash"]["name"]
        end
      end
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  private

  def self.create_new_fb_user(data)
    u = User.new(:username => data["extra"]["user_hash"]["name"], :email => data["extra"]["user_hash"]["email"])
    u.authentications.build(:uid => data["uid"],:provider => data["provider"])
    if u.save
      return u
    else
      User.new
    end
  end
end

