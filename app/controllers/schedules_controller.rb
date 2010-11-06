class SchedulesController < InheritedResources::Base
  include AuthUserAdmin
  before_filter :auth_user_admin!, :except => [:show, :index]
  has_scope :by_tag

  def show
    @schedule = Schedule.find(params[:id])
  end

  def index
    @schedules = apply_scopes(Schedule).all

    unless @schedules.count == 0
      @tags = SchedulesHelper::TagCloud.build.find()
      render :layout => 'with_tagcloud'
    end
  end

  def create
    #remove the empty item
    params[:schedule][:items].delete_if{|i| i[:text] == ""}
    @schedule = Schedule.new(params[:schedule])
    @schedule.user = current_user
    create!
  end
  def update
    params[:schedule][:items].delete_if{|i| i[:text] == ""}
    update!
  end
end

