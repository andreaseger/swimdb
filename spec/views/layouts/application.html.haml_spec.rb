require 'spec_helper'

describe '/layouts/application.html.haml' do
  include Devise::TestHelpers

  describe 'not authenticated' do
    before :each do
      @view.stubs(:user_signed_in?).returns(false)
    end
    it 'should show the default usernav' do
      render
      rendered.should have_selector("div", :id => "user_nav") do
        contain "Home"
        contain "Login"
        contain "SignUp"
      end
      rendered.should_not contain "Signed in as"
      rendered.should_not contain "Edit Profile"
      rendered.should_not contain "Logout"
    end
  end

  describe 'authenticated' do
    before :each do
      @view.stubs(:user_signed_in?).returns(true)
      current_user = Factory.stub(:bob)
      @view.stubs(:current_user).returns(current_user)
    end
    it 'should show the usernav for logged in user' do
      render
      rendered.should have_selector("div", :id => "user_nav") do
        contain "Home"
        contain "Signed in as Bob"
        contain "Logout"
        contain "Edit Profile"
      end
      rendered.should_not contain "Login"
      rendered.should_not contain "SignUp"
    end
  end

end

