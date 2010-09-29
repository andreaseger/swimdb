class Schedule
  include MongoMapper::Document
  timestamps!

  key :name, String, :required => true
  key :description, String, :required => true
  many :items


  def full_schedule_distance

    puts "\n\n\n DEBUG -------"

    distance = 0
    last_outer = 1
    last_inner = 1
    last_level = 0
    for item in items
      puts item
      #item.parse_text    die richtigen daten sind schon in den Factories
#      puts "am ANFANG"
#      puts "o || i || l << last"
#      puts "#{last_outer} || #{last_inner} || #{last_level}"
#      puts "o || i || l || d << current"
#      puts "#{item.outer} || #{item.inner} || #{item.level} || #{item.distance}"

      if item.level == 0
        last_outer = 1
        last_inner = 1
      elsif item.level == 1
        last_inner = 1
      end
#      puts "nach dem zurueck setzen"
#      puts "o || i || l << last"
#      puts "#{last_outer} || #{last_inner} || #{last_level}"

      if item.level == 0
        distance += item.full_distance
      elsif item.level == 1
        distance += item.full_distance * last_outer
      elsif item.level == 2
        distance += item.full_distance * last_outer * last_inner
      end

      last_outer = item.outer unless (item.outer == nil)
      last_inner = item.inner unless (item.inner == nil)
      last_level = item.level

    end
    return distance
  end

end

