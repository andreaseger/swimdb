require 'spec_helper'

describe Schedule do

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

  describe '#date' do
    it 'should deliver the created_at date when nothing else delivered' do
      schedule = Factory(:valid_schedule)
      schedule.date.should == schedule.created_at.to_date
    end
    it 'should deliver the original date when set' do
      schedule = Factory(:valid_schedule, :original_date => 2.days.ago)
      schedule.date.should == 2.days.ago.to_date
    end
    it 'should set original_date if date is given' do
      schedule = Factory(:valid_schedule, :date => 2.days.ago)
      schedule.original_date.should == 2.days.ago.to_date
    end
  end

  describe '#full_schedule_distance' do
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
    it "should calculate the right full distance with a info item" do
      schedule = Factory(:full_distance_with_info)
      schedule.full_schedule_distance.should eql(3650)
    end
  end

  describe '#user' do
    before :each do
      @amy = Factory(:amy)
    end
    it 'should be available if set' do
      schedule = Factory(:valid_schedule, :user => @amy)
      schedule.user.should == @amy
    end
    it 'should be nil if not set' do
      schedule = Factory(:valid_schedule)
      schedule.user.should be_nil
    end
    it 'should be in the list of the users schedules' do
      schedule = Factory(:valid_schedule, :user => @amy)
      @amy.schedules.last.should == schedule
    end
  end

  describe '#parse_text' do
    before(:each) do
      @schedule = Factory.build(:schedule)
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

    it 'should update the items on schedule update with update_attributes' do
      item = Factory(:item, :text => "3*4x200m abwechlselnd Lagen und Kraul")
      @schedule.items << item
      @schedule.save
      @schedule.items[0].update_attributes(:text => "5*400m")
      @schedule.items[0].outer.should == 5
    end
  end

  describe "nested items" do
    it 'should parse the nested items while saving' do
      Factory(:full_distance_test3)
      schedule = Schedule.last
      schedule.items[0].distance.should_not be_nil
      schedule.items[1].distance.should_not be_nil
    end
  end

  describe '#tags' do
    it 'should get the provided tags an save them in the array' do
      schedule = Factory(:valid_schedule, :taggings => "foo, bar baz,lorem")
      schedule.tags.should == ["foo", "bar", "baz", "lorem"]
    end
    it 'should give a string of all assigned tags' do
      schedule = Factory(:valid_schedule, :tags=>["foo", "bar", "baz", "lorem"])
      schedule.taggings.should == "foo bar baz lorem"
    end
    it 'should split strings with a dot correctly' do
      schedule = Factory(:valid_schedule, :taggings => "foo. lorem")
      schedule.tags.should == ["foo", "lorem"]
    end
    it 'should split strings with a comma correctly' do
      schedule = Factory(:valid_schedule, :taggings => "foo, lorem")
      schedule.tags.should == ["foo", "lorem"]
    end
    it 'should split strings with a space correctly' do
      schedule = Factory(:valid_schedule, :taggings => "foo lorem")
      schedule.tags.should == ["foo", "lorem"]
    end
  end

  describe '#scopes' do
    before do
      Factory(:valid_schedule, :tags => ["GA1", "foo", "bar"])
      Factory(:valid_schedule, :tags => ["ga1", "SP", "bar"])
      Factory(:valid_schedule, :tags => ["GA2", "KT", "bar"])
      Factory(:valid_schedule, :tags => ["KT", "SP", "bar"])
      Factory(:valid_schedule, :tags => ["CC", "FLY", "bar"])
    end
    it 'should only deliver schedules with the tag GA1' do
      @schedules = Schedule.by_tag("GA1").all
      @schedules.count.should == 2
      @schedules.each do |s|
        s.taggings.should =~ /GA1/i
      end
    end
    it 'should not be case-sensitive' do
      @schedules = Schedule.by_tag("ga1").all
      @schedules.count.should == 2
    end
  end
end

