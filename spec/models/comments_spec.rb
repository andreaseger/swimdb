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
  describe '#timestamp' do
    before do
      @schedule = Factory(:valid_schedule, :user=>Factory(:bob))
      @user = Factory(:amy)
    end
    it 'should have an individual created_at timestamp' do
      @schedule.comments.build(:user => @user, :body => "hase")
      @schedule.save
      @schedule.created_at.should_not == @schedule.comments[0].created_at
    end
  end
  describe '#cache_user' do
    before do
      @schedule = Factory(:valid_schedule, :user=>Factory(:bob))
      @user = Factory(:amy)
    end
    it 'should call cache_user before_save' do
      @comment = @schedule.comments.build(:user => @user, :body => "hase")
      @comment.should_receive(:cache_user)
      @schedule.save
    end

    it 'should save the username' do
      @schedule.comments.build(:user => @user, :body => "hase")
      @schedule.save
      @schedule.comments[0].cached_user.should == @user.username
    end
  end
end

