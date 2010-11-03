require 'spec_helper'

describe User do
  describe 'when validate' do
    it 'should check presence of email' do
      user = Factory.build(:bob, :email => nil)
      user.should_not be_valid
    end
    it 'should check presence of username' do
      user = Factory.build(:bob, :username => nil)
      user.should_not be_valid
    end

    it 'should check uniquess of the username' do
      Factory(:bob)
      user = Factory.build(:bob, :email => "frank@foo.com")
      user.should_not be_valid
    end
    it 'should check uniquess of the email' do
      Factory(:bob)
      user = Factory.build(:bob, :username => "Frank")
      user.should_not be_valid
    end
  end

  describe '#authentications' do
    it 'should save authentications' do
      user = Factory(:bob)
      user.authentications.build(:uid => '123456789012345', :provider => 'dummy')
      user.save
      user.authentications.count.should == 1
      Authentication.count.should == 1
    end

    it 'should delete the authentications on delete' do
      pending 'in rspec the callback does not work'
      user = Factory(:bob)
      user.authentications.build(:uid => '123456789012345', :provider => 'dummy')
      user.save
      user.delete
      User.count.should == 0
      Authentication.count.should == 0
    end
  end

  describe '#find_for_oauth' do
    before do
      @omniauth = {'uid' => '12345', 'provider' => 'dummy'}
    end
    describe '#logged in' do
      before(:each) do
        @user = Factory(:amy)
      end
      describe '#auth already exists and belongs to another user' do
        before(:each) do
          @bob = Factory(:bob)
          @bob.authentications.create!(:uid => '12345', :provider => 'dummy')
        end
        it 'should raise an exception' do
          lambda {User.find_for_oauth(@omniauth, @user)}.should raise_error('Account already linked to an other user')
        end
      end
      describe '#auth already exists and belongs to the current_user' do
        before(:each) do
          @user.authentications.create!(:uid => '12345', :provider => 'dummy')
        end
        it 'should return the user himself' do
          User.find_for_oauth(@omniauth, @user).should == @user
        end
      end
      describe '#auth not known' do
        it 'should add the authentication to the current_user' do
          User.find_for_oauth(@omniauth, @user)
          @user.should have(1).authentications
        end
      end
    end

    describe '#not logged in' do
      before do
        @user = nil
      end
      describe '#auth already exists' do
        before(:each) do
          @bob = Factory(:bob)
          @bob.authentications.create!(:uid => '12345', :provider => 'dummy')
        end
        it 'should return the user with the given authentication' do
          User.find_for_oauth(@omniauth, @user).should == @bob
        end
      end

      describe '#auth not known' do
        it 'should return a non persisted user' do
          User.find_for_oauth(@omniauth, @user).persisted?.should be_false
        end
        describe '#facebook' do
          before do
              @omniauth = {'uid' => '1235', 'provider'=> 'facebook', 'extra' => {'user_hash' => {'name' => "Foo Bar", 'email' => "bar@foo.com"}}}
          end
          it 'should call create_new_fb_user' do
            User.should_receive(:create_new_fb_user)
            User.find_for_oauth(@omniauth, @user)
          end
          describe '#create_new_fb_user' do
            it 'should create a persisted User with the given params' do
              User.create_new_fb_user(@omniauth).persisted?.should be_true
            end
            it 'should have the username "Foo Bar"' do
              User.create_new_fb_user(@omniauth).username.should == "Foo Bar"
            end
            it 'should have the email "bar@foo.com"' do
              User.create_new_fb_user(@omniauth).email.should == "bar@foo.com"
            end
            it 'should have a facebook authentication' do
              User.create_new_fb_user(@omniauth).authentications[0].provider.should == 'facebook'
            end
            describe '#autocreate is invalid' do
              before do
                Factory(:bob, :username => "Foo Bar")
              end
              it 'should return a non persisted User' do
                User.create_new_fb_user(@omniauth).persisted?.should be_false
              end
            end
          end
        end
      end
    end
  end
  describe '#apply_omniauth' do
    before(:each) do
      @bob = User.new
    end
    describe '#twitter' do
      before do
        @omniauth = {'uid' => '1235', 'provider'=> 'twitter', 'user_info' => {'name' => "Foo Bar", 'image' => "goo.png"}}
      end
      it 'should set name and image' do
        @bob.apply_omniauth(@omniauth)
        @bob.username.should == "Foo Bar"
        @bob.image.should == "goo.png"
      end
    end
    describe '#facebook' do
      before do
        @omniauth = {'uid' => '1235', 'provider'=> 'facebook', 'extra' => {'user_hash' => {'name' => "Foo Bar", 'email' => "bar@foo.com"}}}
      end
      it 'should set username and email' do
        @bob.apply_omniauth(@omniauth)
        @bob.username.should == "Foo Bar"
        @bob.email.should == "bar@foo.com"
      end
    end
    it 'should add an authentication' do
      @omniauth = {'uid' => '1235', 'provider'=> 'facebook', 'extra' => {'user_hash' => {'name' => "Foo Bar", 'email' => "bar@foo.com"}}}
      @bob.apply_omniauth(@omniauth)
      @bob.should have(1).authentications
    end
  end
end

