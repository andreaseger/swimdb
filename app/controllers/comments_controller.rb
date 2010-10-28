class CommentsController < InheritedResources::Base
  belongs_to :schedule
  actions :create, :destroy
  #before_filter :authenticate_user!, :except => [:create]

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @comment = @schedule.comments.build(params[:comment])
    @comment.user = current_user if user_signed_in?

    create! do |success, failure|
      success.html {redirect_to parent_url}
      success.js
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

