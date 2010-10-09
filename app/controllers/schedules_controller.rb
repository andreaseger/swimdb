class SchedulesController < InheritedResources::Base
  def index
    @schedules = Schedule.all
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    params[:items].each_with_index do |item, index|
      item[:rank]=index
      @schedule.items.build(item)
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
    params[:items].each_with_index do |item, index|
      item[:rank]=index
      @schedule.items.build(item)
    end
    create!
  end

end



#< ApplicationController
#
#  def index
#    @schedules = Schedule.all
#  end
#
#  def show
#    @schedule = Schedule.find(params[:id])
#  end
#
#  def new
#    @schedule = Schedule.new
#  end
#
#  def edit
#    @schedule = Schedule.find(params[:id])
#  end
#
#  def create
#    @schedule = Schedule.new(params[:schedule])
#
#    respond_to do |format|
#      if @schedule.save
#        format.html { redirect_to(@schedule, :notice => 'Schedule was successfully created.') }
#        format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  def update
#    @schedule = Schedule.find(params[:id])
#
#    respond_to do |format|
#      if @schedule.update_attributes(params[:schedule])
#        format.html { redirect_to(@schedule, :notice => 'Schedule was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  def destroy
#    @schedule = Schedule.find(params[:id])
#    @schedule.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(schedules_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
#

