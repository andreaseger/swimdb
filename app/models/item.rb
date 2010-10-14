class Item
  include MongoMapper::EmbeddedDocument
  #key :schedule_id, ObjectId
  belongs_to :schedule
  private
    MULTI = '((\d{1,2})(\*|x))?'
    DIST = '(\d+)($|\s|m$|m\s|m,\s)'

    PAT0 = /^#{MULTI}#{MULTI}#{DIST}/i
    PAT1 = /^#{MULTI}#{DIST}/i
    PAT2 = /^#{DIST}/i
  public

  key :level, Integer, :required => true, :only_integer => true, :in => 0..2, :default => 0
  key :text, String, :required => true
  validates_format_of :text, :key => :lvl0, :with =>PAT0, :if => Proc.new { level == 0 }
  validates_format_of :text, :key => :lvl1, :with =>PAT1, :if => Proc.new { level == 1 }
  validates_format_of :text, :key => :lvl2, :with =>PAT2, :if => Proc.new { level == 2 }
  key :rank, Integer, :required => true, :only_integer => true, :greater_than_or_equal => 0, :default => 0

  #parsed
  key :outer, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :inner, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :distance, Integer, :only_integer => true, :greater_than_or_equal => 0

  def full_distance
    i = (self.inner == nil) ? 1 : self.inner
    o = (self.outer == nil) ? 1 : self.outer
    self.distance * i * o
  end
end

