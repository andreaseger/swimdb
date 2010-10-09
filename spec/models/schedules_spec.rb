require 'spec_helper'

describe "schedules.rb" do

  describe 'when validate' do
    %w(name description).each do |attrib|
      it "should validates presence of #{attrib}" do
        schedule = Factory.build(:schedule, attrib => nil)
        schedule.should_not be_valid
      end
    end

    it 'should have at least one item' do
      schedule = Factory.build(:schedule, :items =>[])
      schedule.should_not be_valid
    end

    it 'should nest items' do
      schedule = Factory.build(:schedule, :items => [Item.new(:level => 0, :rank => 0, :text => "300m")])
      schedule.should have(1).items
    end

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

  describe "nested items" do
    it "should create the nested Items" do
      Schedule.count.should == 0
      Item.count.should == 0
      schedule = Factory(:full_distance_test1)
      Schedule.count.should == 1
      schedule.should have(3).items
      Item.count.should == 3
    end
    it "should delete the nested items with the schedule" do
      Schedule.count.should == 0
      Item.count.should == 0
      schedule = Factory(:full_distance_test1)
      # delete it
      schedule.destroy
      Schedule.count.should == 0
      Item.count.should == 0
    end

    it 'should parse the nested items while saving' do
      Factory(:full_distance_test3)
      schedule = Schedule.last
      schedule.items[0].distance.should_not be_nil
      schedule.items[1].distance.should_not be_nil
    end
  end
end

