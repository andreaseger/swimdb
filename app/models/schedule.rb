class Schedule
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description
  field :original_date, :type => Date
  field :tags, :type => Array
  referenced_in :user
  embeds_many :items
  embeds_many :comments
  #belongs_to :user
  before_save :parseItems

  #validates_associated :items
  #validates_associated :comments

  validates_presence_of :name, :description
  validate :itemscount

  def self.by_tag(tag)
    where(:tags => /#{tag}/i)
  end

  def taggings=(value)
    self.tags = value.split(",").join(" ").split(" ") if value
  end
  def taggings
    tags.join(" ") if self.tags
  end

  def date
    original_date == nil ? created_at : original_date
  end
  def date=(value)
    original_date = Date.parse(value) unless value.empty?
  end

  def full_schedule_distance
    distance = 0
    last_outer = 1
    last_inner = 1
    for item in items
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
  MULTI = '((\d{1,2})(\*|x))?'
  DIST = '(\d+)($|\s|m$|m\s|m,\s)'
  def parseItems
    re = /^#{MULTI}#{MULTI}#{DIST}/i
    self.items.each do |item|
      if parse = re.match(item.text)
        case item.level
          when 0
            item.outer = parse[2]
            item.inner = parse[5]
          when 1
            item.outer = nil
            item.inner = parse[2]
          when 2
            item.outer = nil
            item.inner = nil
        end
        item.distance=parse[7]
      end
    end
    true
  end

  def itemscount
    errors.add :items, "There has to be at least 1 Item" if self.items.empty?
  end
end

