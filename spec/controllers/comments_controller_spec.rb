require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end
  before do
    @user = Factory(:bob)
    sign_in @user
  end

  describe "POST create" do
    before do
      @schedule = Factory(:valid_schedule, :user=>@user)
    end
    it 'should increment the comments_count' do
      Schedule.last.comments_count.should == 0
      post :create, :schedule_id => @schedule.id, :comment => {:body => "foo"}
      Schedule.last.comments_count.should == 1
    end
  end


  describe "DELETE destroy" do
    before do
      @schedule = Factory(:valid_schedule, :user=>@user)
      @schedule.comments.build(:user => @user, :body => 'foo').save
      @schedule.comments.build(:user => @user, :body => 'bar').save
      @comment = @schedule.comments.build(:user => @user, :body => 'baz')
      @comment.save
      @schedule.update_attributes({:comments_count => 3})
    end
    it "should decrement the comments_count" do
      delete :destroy, :id => @comment.id, :schedule_id => @schedule.id
      Schedule.last.comments_count.should == 2
    end
  end
end

