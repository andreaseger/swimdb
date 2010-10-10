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

  describe 'when parse_text' do
    before(:each) do
      @schedule = Factory.build(:schedule)
    end
    it 'should call parseItems before save' do
      item = Factory(:item, :text => "3*4x200m abwechlselnd Lagen und Kraul")
      @schedule.items << item
      @schedule.should_receive(:parseItems)
      @schedule.save!
    end
    it "should parse the items before save" do
      item = Factory(:item, :text => "3*4x200m abwechlselnd Lagen und Kraul")
      @schedule.items << item
      @schedule.save
      @schedule.items[0].outer.should_not be_nil
      @schedule.items[0].inner.should_not be_nil
      @schedule.items[0].distance.should_not be_nil
    end
    it 'should update the items on schedule update' do
      item = Factory(:item, :text => "3*4x200m abwechlselnd Lagen und Kraul")
      @schedule.items << item
      @schedule.save
      @schedule.items[0].text = "5*400m"
      @schedule.save
      @schedule.items[0].outer.should == 5
    end

    it "should find the components in a easy example" do
      item = Factory(:item, :text => "3*4x200m abwechlselnd Lagen und Kraul")
      @schedule.items << item
      @schedule.save
      @schedule.items[0].outer.should eq 3
      @schedule.items[0].inner.should eq 4
      @schedule.items[0].distance.should eq 200
    end
    it 'should find the components in a more complex one to' do
      item = Factory(:item, :text => "3*4x200m abwechlselnd Lagen und Kraul bei ca 80 bis 90%")
      @schedule.items << item
      @schedule.save
      @schedule.items[0].outer.should eq 3
      @schedule.items[0].inner.should eq 4
      @schedule.items[0].distance.should eq 200
    end
    it 'should also parse this one correct' do
      item = Factory(:item, :text => "3*200 Kraul mit 50m Antritten")
      @schedule.items << item
      @schedule.save
      @schedule.items[0].outer.should eq 3
      @schedule.items[0].inner.should be_nil
      @schedule.items[0].distance.should eq 200
    end
    it 'should switch inner and outer if its a lvl1 item' do
      item = Factory(:item, :level => 1, :text => "3*200 Kraul mit 50m Antritten")
      @schedule.items << item
      @schedule.save
      @schedule.items[0].outer.should be_nil
      @schedule.items[0].inner.should eq 3
      @schedule.items[0].distance.should eq 200
    end
    it 'should set inner and outer to nil if its a lvl2 item' do
      item = Factory(:item, :level => 2, :text => "200 Kraul mit 50m Antritten")
      @schedule.items << item
      @schedule.save
      @schedule.items[0].outer.should be_nil
      @schedule.items[0].inner.should be_nil
      @schedule.items[0].distance.should eq 200
    end
  end


  describe "nested items" do

    #dont need this tests because its embedded
    #it "should create the nested Items" do
    #  Schedule.count.should == 0
    #  Item.count.should == 0
    #  schedule = Factory(:full_distance_test1)
    #  Schedule.count.should == 1
    #  schedule.should have(3).items
    #  Item.count.should == 3
    #end
    #it "should delete the nested items with the schedule" do
    #  Schedule.count.should == 0
    #  Item.count.should == 0
    #  schedule = Factory(:full_distance_test1)
    #  # delete it
    #  schedule.destroy
    #  Schedule.count.should == 0
    #  Item.count.should == 0
    #end

    it 'should parse the nested items while saving' do
      Factory(:full_distance_test3)
      schedule = Schedule.last
      schedule.items[0].distance.should_not be_nil
      schedule.items[1].distance.should_not be_nil
    end
  end
end

