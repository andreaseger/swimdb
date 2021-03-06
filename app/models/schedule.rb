class Schedule
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :user
  field :title
  field :description
  field :original_date, :type => Date

  field :tags, :type => Array
  embeds_many :items
  accepts_nested_attributes_for :items

  embeds_many :comments
  #cache
  field :cached_user

  before_save :cache_user
  validates_presence_of :title, :description
  validates_presence_of :taggings, :if => Proc.new{ self.tags == nil}

  validates_associated :items
  validates_associated :comments, :allow_nil => true

  validate :itemscount

  def self.by_tag(tag)
    where(:tags => /#{tag}/i)
  end

  #virtual attributes
  def taggings=(value)
    unless value.nil?
      self.tags = value.scan(/\w+|,|\./).delete_if{|t| t =~ /,|\./}
    end
  end
  def taggings
    tags.join(" ") if tags
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
    unless self.user == nil
      self.cached_user = self.user.username
    end
  end

  def itemscount
    errors.add :items, "There has to be at least 1 Item" if self.items.empty?
  end
end

