class Schedule
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :user
  field :name
  field :description
  validates_presence_of :name, :description
  field :original_date, :type => Date

  field :tags, :type => Array
  embeds_many :items
  accepts_nested_attributes_for :items

  embeds_many :comments
  #cache
  field :cached_user

  before_save :cacheUser
  #validate :validate_items, :on => :create
#
  #def validate_items
  #  self.items.each do |item|
  #    if item.valid? == false
  #      errors.add :item, item.errors.full_messages
  #    end
  #  end
  #end

  validates_associated :items#, :allow_nil => true
  validates_associated :comments, :allow_nil => true

  validate :itemscount

  def self.by_tag(tag)
    where(:tags => /#{tag}/i)
  end

  #virtual attributes
  def taggings=(value)
    self.tags = value.split(",").join(" ").split(" ")
  end
  def taggings
    tags.join(" ") if tags
  end

  def date
    original_date == nil ? created_at : original_date
  end
  def date=(value)
    self.original_date = value.to_date if value
  end

  def full_schedule_distance
    distance = 0
    last_outer = 1
    last_inner = 1
    for item in items.sort_by(&:rank)
      if item.level == 0
        distance += item.full_distance
        last_outer = 1
        last_inner = 1
      elsif item.level == 1
        distance += item.full_distance * last_outer
        last_inner = 1
      elsif item.level == 2
        distance += item.full_distance * last_outer * last_inner
      end
      last_outer = item.outer unless (item.outer == nil)
      last_inner = item.inner unless (item.inner == nil)
    end
    return distance
  end

  private

  def cacheUser
    unless self.user == nil
      self.cached_user = self.user.username
    end
  end

  def itemscount
    errors.add :items, "There has to be at least 1 Item" if self.items.empty?
  end
end

