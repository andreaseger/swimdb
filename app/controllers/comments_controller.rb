class CommentsController < InheritedResources::Base
  include AuthUserAdmin
  belongs_to :schedule
  actions :create, :destroy
  before_filter :auth_user_admin!
  #before_filter :authenticate_user!

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @comment = @schedule.comments.build(params[:comment])
    @comment.user = current_user

    create! do |success, failure|
      success.html {redirect_to parent_url}
      success.js
      failure.html { redirect_to parent_url }
      failure.js  { render :text => @comment.errors.full_messages }
    end
    #respond_to do |format|
    #  if @comment.save
    #    flash[:notice] = 'Comment was successfully created.'
    #    format.html { redirect_to schedule_path(@schedule) }
    #    format.js
    #  else
    #    @schedule
    #  end
    #end
  end


  def destroy
    @schedule = Schedule.find(params[:schedule_id])
    @comment = @schedule.comments.find(params[:id])

    @schedule.comments.delete_if{|comment| comment.id == @comment.id}
    if @schedule.save
      flash[:notice] = "Successfully destroyed comment."
      redirect_to @schedule
    else
      flash[:error] = "dag, yo."
    end
  end
end

