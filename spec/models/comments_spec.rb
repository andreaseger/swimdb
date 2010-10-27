require 'spec_helper'

describe Comment do
  describe '#validate' do
    it 'should need a user' do
      comment = Factory.build(:comment, :user => nil)
      comment.should_not be_valid
    end
    it 'should be valid with a user' do
      #comment = Factory.build(:comment, :user => Factory(:bob), :commenter => nil)
      comment = Comment.new(:body => "lorem", :user => Factory(:bob))
      comment.should be_valid
    end
    it 'should need the body' do
      comment = Comment.new(:body => nil, :user => Factory(:bob))
      comment.should_not be_valid
    end
  end
  #describe '#commenter' do
  #  before :each do
  #    @user = Factory(:bob)
  #  end
  #  it 'should be the entered name if no user' do
  #    comment = Factory(:name_comment)
  #    comment.commenter.should == Factory.attributes_for(:name_comment)[:commenter]
  #  end
  #  it 'should not exist a user with the same username' do
  #    comment = Factory.build(:comment, :commenter => @user.username)
  #    comment.should_not be_valid
  #  end
  #end
  #describe '#email' do
  #  it 'should at least look like an address' do
  #    comment = Factory(:name_comment, :email => "foo")
  #    comment.should_not be_valid
  #  end
  #end
  describe '#timestamp' do
    before :each do
      @schedule = Factory(:valid_schedule, :user=>Factory(:bob))
    end
    it 'should have an individual created_at timestamp' do
      @schedule.comments.build(:commenter => "amy", :body => "hase")
      @schedule.save
      @schedule.created_at.should_not == @schedule.comments[0].created_at
    end
  end
end

