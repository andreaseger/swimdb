require 'spec_helper'

describe Users::AuthenticationsController do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "POST create" do
    before do
      controller.stub!(:render)
    end
    it 'should call oath for provider facebook-twitter' do
      controller.stub!(:oauth).and_return(true)
      controller.should_receive(:oauth)
      post :create, :provider => 'facebook'
    end
    describe '#oauth' do
      describe '#logged in' do
        before do
          @user = Factory(:bob)
          sign_in @user
        end
        it 'should redirect to the users authentications page' do
          User.stub!(:find_for_oauth).and_return(@user)
          request.env["omniauth.auth"] = {"provider" => 'facebook'}
          post :create, :provider => 'facebook'
          response.should redirect_to(edit_users_authentication_path(@user))
        end
      end
      describe '#guest' do
        before do
          controller.stub!(:current_user).and_return(nil)
        end
        it 'should sign in and redirect the user' do
          auth = Factory(:facebook)
          User.stub!(:find_for_oauth).and_return(auth.user)
          request.env["omniauth.auth"] = {"provider" => 'facebook'}
          post :create, :provider => 'facebook'
          response.should redirect_to(root_url)
        end
        it 'should redirect to the edit page(facebook)' do
          User.stub!(:find_for_oauth).and_return(User.new)
          request.env["omniauth.auth"] = {"provider" => 'facebook'}
          post :create, :provider => 'facebook'
          response.should redirect_to(new_user_registration_url)
          session["devise.facebook_data"].should_not be_nil
        end
        it 'should redirect to the edit page(twitter)' do
          User.stub!(:find_for_oauth).and_return(User.new)
          request.env["omniauth.auth"] = {"provider" => 'twitter'}
          post :create, :provider => 'twitter'
          response.should redirect_to(new_user_registration_url)
          session["devise.twitter_data"].should_not be_nil
        end
      end
    end
  end

  describe "GET edit" do
    describe '#as admin' do
      before(:each) do
        controller.stub!(:admin_signed_in?).and_return(true)
      end
      it "assigns the requested authentications as @authentications" do
        mu = mock_user(:authentications => [{"uid" => '5', "provider" => 'dummy'}])
        User.stub(:find).with("37") { mu }
        get :edit, :id => "37"
        assigns(:authentications).should == mu.authentications
      end
    end
    describe '#as user' do
      before do
        @auth = Factory(:facebook)
        @user = @auth.user
        sign_in @user
      end
      it "assigns the current_user authentications as @authentications" do
        get :edit, :id => "37"
        assigns(:authentications).all.should == @user.authentications.all
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @auth = Factory(:facebook)
      @user = @auth.user
      sign_in @user
    end
    it "redirects to the authentications list" do
      delete :destroy, :id => @auth.id
      response.should redirect_to(edit_users_authentication_path)
    end
  end
end

