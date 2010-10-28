class SchedulesController < InheritedResources::Base
  before_filter :auth_user_admin, :except => [:show, :index]
  #before_filter :authenticate_user!, :except => []
  has_scope :by_tag

  def show
    @schedule = Schedule.find(params[:id])
    @comment = @schedule.comments.build
  end

  def index
    @schedules = apply_scopes(Schedule).all
    @tags = SchedulesHelper::TagCloud.build.find()
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

  private
  def auth_user_admin
    unless admin_signed_in?
      warden.authenticate!(:scope => :user)
    end

end

