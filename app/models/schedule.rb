class Schedule
  include MongoMapper::Document
  timestamps!

  key :name, String, :required => true
  key :description, String, :required => true
  many :items


  def full_schedule_distance
  #  distance = 0
  #  last_lvl0_outer = 1
  #  last_lvl0_inner = 1
  #  last_lvl1_inner = 1
  #  for item in items
  #    item.parse_text
  #    if item.level == 0
  #      distance += item.full_distance
  #    elsif item.level == 1
  #      distance += item.full_distance * last_lvl0_outer
  #    elsif item.level == 2
  #      distance += item.full_distance * last_lvl0_outer * last_lvl0_inner OR last_lvl1_inner
  #    end
  #    if item.inner
  #      if item.outer
  #        last_multi =
  #      end
  #    end
  #   end
  end

end

