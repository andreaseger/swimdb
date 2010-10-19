class SchedulesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]

  def show
    @schedule = Schedule.find(params[:id])
    @comment = @schedule.comments.build
  end

  def index
    @schedules = Schedule.all
    @tags = SchedulesHelper::TagCloud.build.find()
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    @schedule.user = current_user
    create!
  end
end

