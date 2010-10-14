class SchedulesController < InheritedResources::Base
  def index
    @schedules = Schedule.all
    @tags = SchedulesHelper::TagCloud.build.find()
  end
end

