class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # :confirmable
  devise  :registerable,
          :database_authenticatable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable,
          :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation

  field :username
  field :image

  references_many :schedules
  references_many :comments
  references_many :authentications, :dependent => :destroy

  #validates_associated :comments, :allow_nil => true
  #validates_associated :schedules
  validates_presence_of :username
  validates_uniqueness_of :username
  validate :validate_authentications, :unless => Proc.new {self.authentications == []}

  def self.find_for_oauth(omniauth, user)
    auth = Authentication.where(:uid => omniauth["uid"], :provider => omniauth["provider"]).first
    if user
      # the user wants to add fb to his account
      if auth
        return user if auth.user == user
        raise 'Account already linked to an other user'
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
      else
        User.new()
      end
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def apply_omniauth(data)
    case data["provider"]
    when 'facebook'
      self.username = data["extra"]["user_hash"]["name"] if username.blank?
      self.email = data["extra"]["user_hash"]["email"] if email.blank?
    when 'twitter'
      self.username = data["user_info"]["name"] if username.blank?
      self.image = data["user_info"]["image"] if image.blank?
    end
    authentications.build(:uid => data["uid"],:provider => data["provider"])
  end

  private
  def self.new_fb_user(data)
    u = User.new(:username => data["extra"]["user_hash"]["name"], :email => data["extra"]["user_hash"]["email"])
    u.authentications.build(:uid => data["uid"],:provider => data["provider"])
    return u
  end

  def self.create_new_fb_user(data)
    u = new_fb_user(data)
    if u.save
      return u
    else
      User.new
    end
  end

  def validate_authentications
    authentications.each do |auth|
      if auth.valid? == false
        errors.add :authentication, auth.errors.full_messages
      end
    end
  end

#  def self.new_with_session(params, session)
#    super.tap do |user|
#      #case facebook
#      if data = session["devise.facebook_data"]
#        user.authentications.build(:uid => data["uid"],:provider => data["provider"])
#        user.email = data["extra"]["user_hash"]["email"] unless user.email || user.email == ""
#        unless user.username || user.username = ""
#            user.username = data["extra"]["user_hash"]["name"]
#        end
#      elsif data = session["devise.twitter_data"]
#        user.authentications.build(:uid => data["uid"],:provider => data["provider"])
#        user.email = data["extra"]["user_hash"]["email"] unless user.email || user.email == ""
#        unless user.username || user.username = ""
#            user.username = data["extra"]["user_hash"]["name"]
#        end
#      end
#    end
#  end
end

