class Comment
  include Mongoid::Document
  embedded_in :schedule, :inverse_of => :comments
  referenced_in :user

  field :body
  field :created_at, :type => Time
  field :cached_user
  validates_presence_of :user, :body

  after_validation :cache_user
  after_validation :set_created_at


  private
  def set_created_at
    self.created_at = Time.now
    true
  end

  def cache_user
    unless self.user == nil
      self.cached_user = self.user.username
    end
    true
  end
end

