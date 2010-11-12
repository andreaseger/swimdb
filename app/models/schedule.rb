class Schedule
  include MongoMapper::Document
  timestamps!

  key :name, String, :required => true
  key :description, String, :required => true
  key :original_date, Date
  key :tags, Array, :index => true
  many :items, :dependent => :destroy
  many :comments, :dependent => :destroy
  #cache
  key :cached_user, String
  key :comments_count, Integer, :default => 0

  belongs_to :user
  before_save :cache_user

  validates_associated :items
  validates_associated :comments
  validate :itemscount

  def self.by_tag(tag)
    where(:tags => /#{tag}/i)
  end

  #virtual attributes
  def taggings=(value)
    self.tags = value.scan(/\w+|,|\./).delete_if{|t| t =~ /,|\./}
  end
  def taggings
    tags.join(" ")
  end

  def date
    if original_date == nil
      created_at.to_date if created_at
    else
      original_date
    end
  end
  def date=(value)
    self.original_date = value if value
  end

  def full_schedule_distance
    distance = 0
    last_outer = 1
    last_inner = 1
    for item in items
      if item.info
        next
      end
      case item.level
        when 0
          distance += item.full_distance
          last_outer = 1
          last_inner = 1
        when 1
          distance += item.full_distance * last_outer
          last_inner = 1
        when 2
          distance += item.full_distance * last_outer * last_inner
      end
      last_outer = item.outer unless (item.outer == nil)
      last_inner = item.inner unless (item.inner == nil)
    end
    return distance
  end

  private

  def cache_user
    self.cached_user = self.user.username
  end

  def itemscount
    errors.add :items, "There has to be at least 1 Item" if self.items.empty?
  end
end

