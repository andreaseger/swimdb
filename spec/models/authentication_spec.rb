require 'spec_helper'

describe Authentication do
  describe '#validation' do
    before(:each) do
      @user = Factory(:amy)
    end
    it 'should allow the same provider for different users' do
      auth = Factory(:facebook)
      a = Authentication.new(:uid => '12321232123', :provider => auth.provider)
      @user.authentications << a
      @user.should be_valid
    end
    it 'should allow the same uid for different providers' do
      auth = Factory(:facebook)
      a = Authentication.new(:uid => auth.uid, :provider => 'foobar')
      @user.authentications << a
      @user.should be_valid
    end
    it 'should check the uniquess of uid-provider' do
      auth = Factory(:facebook)
      a = Authentication.new(:uid => auth.uid, :provider => auth.provider)
      @user.authentications << a
      @user.should_not be_valid
    end
    it 'should check the uniquess of user_id-provider' do
      auth = Factory(:facebook, :user => @user)
      a = Authentication.new(:uid => '543210987654321', :provider => auth.provider)
      @user.authentications << a
      @user.should_not be_valid
    end
    it 'should check the presence of user_id' do
      auth = Factory.build(:facebook, :user_id => nil)
      auth.should_not be_valid
    end
  end
end

