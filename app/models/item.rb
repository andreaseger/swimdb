class Item
  include MongoMapper::Document

  key :level, Integer, :required => true, :only_integer => true, :in => 0..2
  key :text, String, :required => true

  #chached
  key :outer, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :inner, Integer, :only_integer => true, :greater_than_or_equal => 0
  key :distance, Integer, :only_integer => true, :greater_than_or_equal => 0

  def parse_text
    # here I try to parse the distance of the item
    # der text sollte wie einer der folgenden aussehen
      # 400(m)            /(\d+)m?/                     1:400
      # 3(*|x)200(m|)     /((\d)(\*|x))?(\d+)m?/        1:4x    2:4   3:x   4:200
      # "3x4x500m"        /((\d)(\*|x))?((\d)(\*|x))?(\d+)m?/  1:"3x" 2:"3" 3:"x" 4:"4x" 5:"4" 6:"x" 7:"500"
    #LVL2 = /(\d+)m?/
    #LVL1 = /((\d)(\*|x))?(\d+)m?/
    #LVL0 = /((\d)(\*|x))?((\d)(\*|x))?(\d+)m?/

    #switch self.level
    #  case 0
    #
    #  case 1
    #
    #  case 2
    #
    #end

    parse = self.text.match(/((\d)(\*|x))?((\d)(\*|x))?(\d+)m?/)
      #parse[0]  #3x4x500m
      #parse[1]  #3x
      self.outer=parse[2]  #3
      #parse[3]  #x
      #parse[4]  #4x
      self.inner=parse[5]  #4
      #parse[6]  #x
      self.distance=parse[7]  #500
  end

  def full_distance
    if self.inner
      if self.outer
        self.outer * self.inner * self.distance
      else
        self.inner * self.distance
      end
    else
      self.distance
    end
  end
end

