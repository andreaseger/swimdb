class SchedulesController < InheritedResources::Base
  include AuthUserAdmin
  before_filter :auth_user_admin!, :except => [:show, :index]
  has_scope :by_tag

  def show
    @schedule = Schedule.find(params[:id])
  end

  def index
    debugger
    @schedules = Schedule.search
    #@schedules = apply_scopes(Schedule).all
    #unless @schedules.count == 0
    #  @tags = SchedulesHelper::TagCloud.build.find()
    #  render :layout => 'with_tagcloud'
    #end
  end

  def create
    #remove the empty item
    params[:schedule][:items].delete_if{|i| i[:text] == ""}
    @schedule = Schedule.new(params[:schedule])
    @schedule.user = current_user
    create!
  end

  #def update
  #  params[:schedule][:items].delete_if{|i| i[:text] == ""}
  #  @schedule = Schedule.find(params[:id])
  #  if @schedule.update_attributes(params[:schedule])
  #    flash[:notice] = "Successfully updated genre."
  #    redirect_to @schedule
  #  else
  #    render :action => 'edit'
  #  end
  #end



  def update
    items = params[:schedule][:items].delete_if{|i| i[:text] == ""}

    i = []
    errors = false
    items.each do |item|
      i.push(Item.new(item))
      unless i.last.valid?
        errors = true
      end
    end
    @schedule = Schedule.find(params[:id])

    if errors
      @schedule.items = i
      @schedule.valid?
      render :action => 'edit'
      return
    else
      #now i know that all items are valid
      if @schedule.items.count >= items.count
        #more items in the schedule than in the hash => delete them
        @schedule.items.each_with_index do |item, index|
          if index > items.count-1
            @schedule.items[index].delete
          else
            @schedule.items[index].update_attributes(items[index])
          end
        end
      else
        #more items in the hash => create new items
        items.each_with_index do |item, index|
          if index > @schedule.items.count-1
            #create new items
            @schedule.items.build(item)
          else
            @schedule.items[index].update_attributes(item)
          end
        end
        @schedule.save
      end
      params[:schedule].delete("items")

      update!
    end
  end
end

