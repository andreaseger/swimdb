class SchedulesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]
  has_scope :by_tag

  def show
    @schedule = Schedule.find(params[:id])
  end

  def index
    @schedules = apply_scopes(Schedule).all
    @tags = SchedulesHelper::TagCloud.build.find()
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    @schedule.user = current_user
    create!
  end
end

