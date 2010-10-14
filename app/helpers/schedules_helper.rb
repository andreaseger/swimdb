module SchedulesHelper
  def add_item_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, "items", :partial => 'item', :object => Item.new
    end
  end

  # map_reduce für die Tags aller Schedules
  class TagCloud
    def self.map
      <<-MAP
      function(){
        this.tags.forEach(function(tag){
          emit(tag, 1);
        });
      }
      MAP
    end

    def self.reduce
      <<-REDUCE
      function(prev, current) {
        var count = 0;
        for (index in current) {
            count += current[index];
        }
        return count;
      }
      REDUCE
    end

    def self.build
      Schedule.collection.map_reduce(map, reduce, :query => {})
    end
  end

end

