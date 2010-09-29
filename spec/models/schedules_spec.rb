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

  describe 'full_schedule_distance' do
    it "should calculate the right full distance if all items lvl0" do
      schedule = Factory(:full_distance_test1)
      schedule.full_schedule_distance.should eql(3500)
    end

    it "should calculate the right full distance if there is a lvl1 item" do
      schedule = Factory(:full_distance_test2)
      schedule.full_schedule_distance.should eql(3650)
    end

    it "should calculate the right full distance if there is a lvl2 item" do
      schedule = Factory(:full_distance_test3)
      schedule.full_schedule_distance.should eql(2250)
    end
    it "should calculate the right full distance if there is a lvl1 item with inner multi" do
      schedule = Factory(:full_distance_test4)
      schedule.full_schedule_distance.should eql(1800)
    end
    it "should calculate the right full distance if there is a lvl1 item where the parent item has no multi" do
      schedule = Factory(:full_distance_test5)
      schedule.full_schedule_distance.should eql(450)
    end
    it "should calculate the right full distance if there is a lvl2 item where the parent item has no inner multi" do
      schedule = Factory(:full_distance_test6)
      schedule.full_schedule_distance.should eql(1650)
    end

    it "should calculate the right full distance if there is a mix of all the above" do
      schedule = Factory(:full_distance_test7)
      schedule.full_schedule_distance.should eql(6200)
    end
    it "should calculate the right full distance if there is a mix of all the above2" do
      schedule = Factory(:full_distance_test7ext)
      schedule.full_schedule_distance.should eql(8300)
    end
  end
end

