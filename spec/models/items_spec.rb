require 'spec_helper'

describe "items.rb" do

  describe 'validations' do
    %w(level text).each do |attrib|
      it "should validates presence of #{attrib}" do
        item = Factory.build(:item, attrib => nil)
        item.save.should eq false
      end
    end

    it 'should validates that the level is in 0..2' do
      item1 = Factory.build(:item, :level => 0)
      item2 = Factory.build(:item, :level => 2)
      item3 = Factory.build(:item, :level => 4)
      item4 = Factory.build(:item, :level => -3)
      #positive test
      [item1, item2].each do |item|
        item.save.should eq true
      end
      #negative test
      [item3, item4].each do |item|
        item.save.should eq false
      end
    end
  end

  describe 'parse_text' do
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
  end

  it 'should calculate the correct full distance' do
    item = Factory(:item, :inner => 5, :outer => 2, :distance => 100)
    item.full_distance.should eq 1000
  end

end

