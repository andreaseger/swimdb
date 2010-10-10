require 'spec_helper'
#require 'devise/test_helpers'

describe '/layouts/application.html.haml' do
  include Devise::TestHelpers

  describe 'not authenticated' do
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
      @view.current_user.stub!(:username).and_return("bob")
      @view.stub!(:user_signed_in?).and_return(true)
    end
    it 'should show the usernav for logged in user' do
      render
      rendered.should have_selector("div", :id => "user_nav") do
        contain "Home"
        contain "Signed in as bob"
        contain "Logout"
        contain "Edit Profile"
      end
      rendered.should_not contain "Login"
      rendered.should_not contain "SignUp"
    end
  end

end

