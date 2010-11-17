class Item
  include Mongoid::Document
  embedded_in :schedule, :inverse_of => :items

  private
    MULTI = '((\d{1,2})(\*|x))?'
    DIST = '(\d+)($|\s|m$|m\s|m,\s)'
    INFO = '=>\s?.+'

    REGEX = "#{MULTI}#{MULTI}#{DIST}"
    PAT0 = /^(#{INFO}|#{REGEX})/i
    PAT1 = /^(#{INFO}|#{MULTI}#{DIST})/i
    PAT2 = /^(#{INFO}|#{DIST})/i
  public

  field :level, :type => Integer
  field :text
  field :info

  #parsed
  field :outer, :type => Integer
  field :inner, :type => Integer
  field :distance, :type => Integer

  attr_accessible :level, :text, :full_distance, :info

  validates_presence_of :text
  validates_format_of :text, :key => :lvl0, :with =>PAT0, :if => Proc.new { self.level == 0 }
  validates_format_of :text, :key => :lvl1, :with =>PAT1, :if => Proc.new { self.level == 1 }
  validates_format_of :text, :key => :lvl2, :with =>PAT2, :if => Proc.new { self.level == 2 }

  validates :level,
            :numericality => {:only_integer => true},
            :inclusion => { :in => 0..2 },
            :presence => true

  validates_numericality_of :outer, :greater_than_or_equal_to => 0, :only_integer => true, :allow_nil => true
  validates_numericality_of :inner, :greater_than_or_equal_to => 0, :only_integer => true, :allow_nil => true
  validates_numericality_of :distance, :greater_than_or_equal_to => 0, :only_integer => true, :allow_nil => true

  after_validation :parse_text
  before_validation :set_level

  def full_distance
    i = (self.inner == nil) ? 1 : self.inner
    o = (self.outer == nil) ? 1 : self.outer
    self.distance * i * o
  end

  private

  def set_level
    if self.level == nil
      self.level = 0
    end
  end

  def parse_text
    if parse = (/^#{REGEX}/i).match(self.text)
      # a valid item is given
      case self.level
        when 0
          self.outer = parse[2]
          self.inner = parse[5]
        when 1
          self.outer = nil
          self.inner = parse[2]
        when 2
          self.outer = nil
          self.inner = nil
      end
      self.distance=parse[7]
      self.info = nil
      true
    elsif parse = (/=>\s?(.+)/i).match(self.text)
      # a info item is given
      self.info = parse[1]
    end
  end
end

