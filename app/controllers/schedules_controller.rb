class SchedulesController < InheritedResources::Base
  #belongs_to :user, :optional => true
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @schedules = Schedule.all
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    #build the items
    unless params[:items] == nil
      params[:items].each_with_index do |item, index|
        item[:rank]=index
        @schedule.items.build(item)
      end
    end
    create!
  end

  def update
    @schedule = Schedule.find(params[:id])
    # only update the schedule keys
    @schedule.name = params[:schedule][:name]
    @schedule.description = params[:schedule][:description]
    # now update the items
    # not brilliant but working for now
    @schedule.items.delete_all
    unless params[:items] == nil
      params[:items].each_with_index do |item, index|
        item[:rank]=index
        @schedule.items.build(item)
      end
    end
    create!
  end
end

