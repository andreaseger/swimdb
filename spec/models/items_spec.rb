require 'spec_helper'

describe "items.rb" do

  describe 'validations' do

    %w(level text rank).each do |attrib|
      it "should validates presence of #{attrib}" do
        item = Factory.build(:item, attrib => nil)
        item.should_not be_valid
      end
    end

    it 'should validates that the level is in 0..2' do
      item1 = Factory.build(:item, :level => 0)
      item2 = Factory.build(:item, :level => 2)
      item3 = Factory.build(:item, :level => 4)
      item4 = Factory.build(:item, :level => -3)
      #positive test
      [item1, item2].each do |item|
        item.should be_valid
      end
      #negative test
      [item3, item4].each do |item|
        item.should_not be_valid
      end
    end

    it 'should validate the text pattern' do
      item = Factory.build(:item, :level => 0, :text => '3x5x2x100m')
      item.should_not be_valid
      item = Factory.build(:item, :level => 0, :text => '3x5x100m')
      item.should be_valid
    end

    it 'should validate the text pattern for lvl 1 items' do
      item = Factory.build(:item, :level => 1, :text => '3x5x100m')
      item.should_not be_valid
      item = Factory.build(:item, :level => 1, :text => '3x100m')
      item.should be_valid
    end
    it 'should validate the text pattern for lvl 2 items' do
      item = Factory.build(:item, :level => 2, :text => '3x100m')
      item.should_not be_valid
      item = Factory.build(:item, :level => 2, :text => '100m')
      item.should be_valid
    end
  end

  describe 'when parse_text' do
    it "should find the components in a easy example" do
      item = Factory(:item, :text => "3*4x200m abwechlselnd Lagen und Kraul")
      item.parse_text
      item.outer.should eq 3
      item.inner.should eq 4
      item.distance.should eq 200
    end
    it 'should find the components in a more complex one to' do
      item = Factory(:item, :text => "3*4x200m abwechlselnd Lagen und Kraul bei ca 80 bis 90%")
      item.parse_text
      item.outer.should eq 3
      item.inner.should eq 4
      item.distance.should eq 200
    end
    it 'should also parse this one correct' do
      item = Factory(:item, :text => "3*200 Kraul mit 50m Antritten")
      item.parse_text
      item.outer.should eq 3
      item.inner.should eq nil
      item.distance.should eq 200
    end
    it 'should switch inner and outer if its a lvl1 item' do
      item = Factory(:item, :level => 1, :text => "3*200 Kraul mit 50m Antritten")
      item.parse_text
      item.outer.should eq nil
      item.inner.should eq 3
      item.distance.should eq 200
    end
    it 'should set inner and outer to nil if its a lvl2 item' do
      item = Factory(:item, :level => 2, :text => "200 Kraul mit 50m Antritten")
      item.parse_text
      item.outer.should eq nil
      item.inner.should eq nil
      item.distance.should eq 200
    end
  end

  it 'should calculate the correct full distance' do
    item = Factory(:item, :inner => 5, :outer => 2, :distance => 100)
    item.full_distance.should eq 1000

    item = Factory(:item, :inner => 7, :outer => 3, :distance => 50)
    item.full_distance.should eq 1050

    item = Factory(:item, :inner => nil, :outer => 5, :distance => 50)
    item.full_distance.should eq 250

    item = Factory(:item, :inner => 5, :outer => nil, :distance => 50)
    item.full_distance.should eq 250
  end

end

