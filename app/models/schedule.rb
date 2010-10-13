class Schedule
  include MongoMapper::Document
  timestamps!

  key :name, String, :required => true
  key :description, String, :required => true
  many :items, :dependent => :destroy
  key :original_date, Date
  belongs_to :user

  validates_associated :items
  validate :itemscount

  def itemscount
    errors.add :items, "There has to be at least 1 Item" if self.items.empty?
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
    for item in items.sort(:rank)
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

end

