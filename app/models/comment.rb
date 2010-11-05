class Comment
  include MongoMapper::EmbeddedDocument
  belongs_to :schedule
  belongs_to :user

  key :body, String, :required => true
  key :created_at, Time, :default => Proc.new {Time.now}
  key :cached_user, String
  validates_presence_of :user
  before_save :cache_user

  private
  def cache_user
    self.cached_user = self.user.username
  end
end

