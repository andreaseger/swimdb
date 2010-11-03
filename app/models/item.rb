class Item
  include Mongoid::Document
  embedded_in :schedule, :inverse_of => :items

  private
    MULTI = '((\d{1,2})(\*|x))?'
    DIST = '(\d+)($|\s|m$|m\s|m,\s)'

    PAT0 = /^#{MULTI}#{MULTI}#{DIST}/i
    PAT1 = /^#{MULTI}#{DIST}/i
    PAT2 = /^#{DIST}/i
  public

  field :level, :type => Integer, :default => 0
  field :text
  validates_format_of :text, :key => :lvl0, :with =>PAT0, :if => Proc.new { level == 0 }
  validates_format_of :text, :key => :lvl1, :with =>PAT1, :if => Proc.new { level == 1 }
  validates_format_of :text, :key => :lvl2, :with =>PAT2, :if => Proc.new { level == 2 }
  field :rank, :type => Integer

  #parsed
  field :outer, :type => Integer
  field :inner, :type => Integer
  field :distance, :type => Integer

  validates_presence_of :level, :text
  validates_numericality_of :level, :only_integer => true, :in => 0..2

  validates_numericality_of :outer, :only_integer => true, :greater_than_or_equal_than => 0
  validates_numericality_of :inner, :only_integer => true, :greater_than_or_equal_than => 0
  validates_numericality_of :distance, :only_integer => true, :greater_than_or_equal_than => 0


  def full_distance
    i = (self.inner == nil) ? 1 : self.inner
    o = (self.outer == nil) ? 1 : self.outer
    self.distance * i * o
  end

end

