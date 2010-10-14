require 'spec_helper'

describe Item do

  describe 'when validation' do

    it "should validates presence of text" do
      item = Factory.build(:item, :text => nil)
      item.should_not be_valid
    end
    it 'should default level to 0' do
      item = Factory.build(:item, :level => nil)
      item.level.should == 0
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
    it 'should validate item multiplier > 10' do
      item = Factory.build(:item, :level => 0, :text => '10*20x100m')
      item.should be_valid
    end
  end

  describe 'when full_distance' do
    it 'should calculate the correct ex1' do
      item = Factory.build(:item, :inner => 5, :outer => 2, :distance => 100)
      item.full_distance.should eq 1000
    end
    it 'should calculate the correct ex2' do
      item = Factory.build(:item, :inner => 7, :outer => 3, :distance => 50)
      item.full_distance.should eq 1050
    end
    it 'should calculate the correct if inner is nil' do
      item = Factory.build(:item, :inner => nil, :outer => 5, :distance => 50)
      item.full_distance.should eq 250
    end
    it 'should calculate the correct if outer is nil' do
      item = Factory.build(:item, :inner => 5, :outer => nil, :distance => 50)
      item.full_distance.should eq 250
    end
    it 'should calculate the correct if inner and outer is nil' do
      item = Factory.build(:item, :inner => nil, :outer => nil, :distance => 50)
      item.full_distance.should eq 50
    end
  end
end

