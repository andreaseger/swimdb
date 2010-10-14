class SchedulesController < InheritedResources::Base
  #belongs_to :user, :optional => true
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @schedules = Schedule.all
    @tags = SchedulesHelper::TagCloud.build.find()
  end

  def create
    debugger
    create!
  end
end

