require 'rubygems'
require 'sunspot'

module SunspotHelper

  class InstanceAdapter < Sunspot::Adapters::InstanceAdapter
    def id
      @instance.id.to_s  # return the book number as the id
    end
  end

  class DataAccessor < Sunspot::Adapters::DataAccessor
    def load( id )
      Schedule.find(id)
    end

    def load_all( ids )
      ids.map { |id| Schedule.find(id) }
    end
  end

end

