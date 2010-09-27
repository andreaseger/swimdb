require 'spec_helper'

describe SchedulesController do

  def mock_schedule(stubs={})
    @mock_schedule ||= mock_model(Schedule, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all schedules as @schedules" do
      Schedule.stub(:all) { [mock_schedule] }
      get :index
      assigns(:schedules).should eq([mock_schedule])
    end
  end

  describe "GET show" do
    it "assigns the requested schedule as @schedule" do
      Schedule.stub(:find).with("37") { mock_schedule }
      get :show, :id => "37"
      assigns(:schedule).should be(mock_schedule)
    end
  end




#  describe 'index' do
#    it "should provide a collection of schedules" do
#      get :index
#      #TODO checken obs n @schedules gibt
#    end
#  end
#  describe 'show'
#    it "should provide one schedule" do
#      get :show, :id => 23
#    end
#  end
end

