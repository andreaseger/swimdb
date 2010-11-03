class Comment
  include Mongoid::Document
  embedded_in :schedule, :inverse_of => :comments
  referenced_in :user

  field :body
  field :created_at, :type => Time, :default => Proc.new {Time.now}
  field :cached_user
  validates_presence_of :user, :body

  before_create :cache_user

  def cache_user
    if user
      self.cached_user = user.username
    end
  end
end

