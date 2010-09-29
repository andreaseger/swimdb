class Schedule
  include MongoMapper::Document
  timestamps!

  key :name, String, :required => true
  key :description, String, :required => true
  many :items


  def full_schedule_distance

    distance = 0
    last_outer = 1
    last_inner = 1
#    sitems = self.items.sort(:rank)
    for item in items.sort(:rank)
      item.parse_text         #evtl noch wo anders

      if item.level == 0
        last_outer = 1
        last_inner = 1
      elsif item.level == 1
        last_inner = 1
      end

      if item.level == 0
        distance += item.full_distance
      elsif item.level == 1
        distance += item.full_distance * last_outer
      elsif item.level == 2
        distance += item.full_distance * last_outer * last_inner
      end

      last_outer = item.outer unless (item.outer == nil)
      last_inner = item.inner unless (item.inner == nil)

    end
    return distance
  end

end

