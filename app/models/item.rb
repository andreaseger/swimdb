class Item
  include MongoMapper::EmbeddedDocument
  belongs_to :schedule

  private
    MULTI = '((\d{1,2})(\*|x))?'
    DIST = '(\d+)($|\s|m$|m\s|m,\s)'
    INFO = '=>\s?.+'

    REGEX = "#{MULTI}#{MULTI}#{DIST}"
    PAT0 = /^(#{INFO}|#{REGEX})/i
    PAT1 = /^(#{INFO}|#{MULTI}#{DIST})/i
    PAT2 = /^(#{INFO}|#{DIST})/i
  public

  key :level, Integer, :required => true, :only_integer => true, :in => 0..2, :default => 0
  key :text, String, :required => true
  validates_format_of :text, :key => :lvl0, :with =>PAT0, :if => Proc.new { level == 0 }
  validates_format_of :text, :key => :lvl1, :with =>PAT1, :if => Proc.new { level == 1 }
  validates_format_of :text, :key => :lvl2, :with =>PAT2, :if => Proc.new { level == 2 }

  #parsed
  key :outer, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :inner, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :distance, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :info, String

  attr_accessible :level, :text, :full_distance, :info

  def full_distance
    i = (self.inner == nil) ? 1 : self.inner
    o = (self.outer == nil) ? 1 : self.outer
    self.distance * i * o
  end

  after_validation :parse_text

  private
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

