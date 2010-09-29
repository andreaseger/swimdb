class Item
  include MongoMapper::Document

  key :level, Integer, :required => true, :only_integer => true, :in => 0..2
  key :text, String, :required => true

  #chached
  key :outer, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :inner, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :distance, Integer, :only_integer => true, :greater_than_or_equal => 0

  def parse_text
    parse = self.text.match(/((\d)(\*|x))?((\d)(\*|x))?(\d+)m?/)
      case self.level
      	when 0
      		self.outer = parse[2]
      		self.inner = parse[5]
      	when 1
      	  self.outer = nil#parse[5]
      	  self.inner = parse[2]
      	when 2
      	  self.outer = nil#parse[5]
      	  self.inner = nil#parse[2]
      end

      #parse[0]  #3x4x500m
      #parse[1]  #3x
      #self.outer=parse[2]  #3
      #parse[3]  #x
      #parse[4]  #4x
      #self.inner=parse[5]  #4
      #parse[6]  #x
      self.distance=parse[7]  #500
  end

  def full_distance
    i = (self.inner == nil) ? 1 : self.inner
    o = (self.outer == nil) ? 1 : self.outer
    self.distance * i * o
  end
end

