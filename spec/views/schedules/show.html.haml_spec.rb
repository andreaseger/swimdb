require 'spec_helper'

describe "/schedules/show.html.haml" do
  #include Devise::TestHelpers
  before(:each) do
    user = Factory(:amy)
    assign(:schedule, Factory(:valid_schedule, :user => user))
    assign(:comment, Comment.new(:body => "lorem", :user => user))
    @view.stubs(:user_signed_in?).returns(false)
    @view.stubs(:admin_signed_in?).returns(false)
  end

  it "should show the basic elements of the schedule" do
    render
    rendered.should have_selector("div") do
      have_selector("strong", :class => 'title')
      have_selector("em", :class => 'cinfo')
      have_selector("ul", :class => 'items')
    end
  end
  describe '#comments' do
    it 'should show the comments area' do
      render
      rendered.should have_selector("div", :id => "comments_area") do
        have_selector(:id => "comments_count")
        have_selector(:id => "comments")
      end
    end
    describe 'logged in' do
      before do
        @user = Factory.stub(:bob)
        @view.stubs(:user_signed_in?).returns(true)
        @view.stubs(:admin_signed_in?).returns(false)
        @view.stubs(:current_user).returns(@user)
        #sign_in @user
      end
      it 'should only show the body field for the CommentsForm' do
        render
        rendered.should have_selector("form") do
          have_selector("ul", :class => "formlist") do
            have_selector("div", "Body")
          end
        end
      end
    end
    describe 'guest' do
      it 'should not show the comments form' do
        render
        rendered.should_not have_selector("form")
      end
    end
  end
end

