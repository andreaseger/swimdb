require 'spec_helper'

describe Comment do
  describe '#validate' do
    it 'should need either a commenter or a user' do
      comment = Factory.build(:comment, :commenter => nil, :user => nil)
      comment.should_not be_valid
    end
    it 'should not need a commenter if a user is given' do
      #comment = Factory.build(:comment, :user => Factory(:bob), :commenter => nil)
      comment = Comment.new(:body => "lorem", :user => Factory(:bob), :commenter => nil)
      comment.should be_valid
    end
    it 'should not need a user if a commenter is' do
      #comment = Factory.build(:comment, :user => nil, :commenter => "hase")
      # not sure why the Factory doesnot work
      comment = Comment.new(:body => "lorem", :user => nil, :commenter => "hase")
      comment.should be_valid
    end
    it 'should need the body' do
      comment = Factory.build(:name_comment, :body => nil)
      comment.should_not be_valid
    end
  end
  describe '#commenter' do
    before :each do
      @user = Factory(:bob)
    end
    it 'should be the entered name if no user' do
      comment = Factory(:name_comment)
      comment.commenter.should == Factory.attributes_for(:name_comment)[:commenter]
    end
    it 'should not exist a user with the same username' do
      comment = Factory.build(:comment, :commenter => @user.username)
      comment.should_not be_valid
    end
  end
  describe '#email' do
    it 'should at least look like an address' do
      comment = Factory(:name_comment, :email => "foo")
      comment.should_not be_valid
    end
  end
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

