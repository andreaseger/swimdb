class Comment
  include MongoMapper::EmbeddedDocument
  belongs_to :schedule
  belongs_to :user

  key :commenter, String
  key :body, String, :required => true
  key :email, String
  key :created_at, DateTime, :default => Proc.new {Time.now}

  #validates_format_of :email,
  #                    :with    => /[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/,
  #                    :message => "this looks not like an email address"

  validate :commenter_username
  def commenter_username
    errors.add :commenter, "a user with that name exists, choose another or login" if User.find_by_username(commenter)
  end
  validate :commenter_user
  def commenter_user
    errors.add :commenter, "a name is needed to post the comment" if (user == nil && commenter == nil)
  end
end

