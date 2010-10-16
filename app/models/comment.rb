class Comment
  include MongoMapper::EmbeddedDocument
  belongs_to :schedule
  belongs_to :user

  key :commenter, String
  key :body, String, :required => true
  key :email, String
  key :created_at, Time, :default => Proc.new {Time.now}

  EMAIL_REGEX = /^([\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+\.)*[\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)$/i

  validates_format_of :email,
                      :with    => EMAIL_REGEX,
                      :message => "this looks not like an email address",
                      :if => Proc.new { email && email != ""}

  validate :commenter_username
  def commenter_username
    errors.add :commenter, "a user with that name exists, choose another or login" if User.find_by_username(commenter)
  end
  validate :commenter_user
  def commenter_user
    errors.add :commenter, "a name is needed to post the comment" if (user == nil && commenter == nil)
  end


end

