require 'spec_helper'

describe "schedules.rb" do

  %w(name description).each do |attrib|
    it "should validates presence of #{attrib}" do
      schedule = Factory.build(:schedule, attrib => nil)
      schedule.save.should == false
    end
  end

  it "should have a relation to items" do
    #TODO da gibt nen should_have ausdruck der checkt ob eine relation vorhanden ist...
  end

  it "should calculate the right full distance for the schedule" do
    @schedule = Factory(:full_distance_test)
    @schedule.full_schedule_distance.should eql(3650)
  end

end

