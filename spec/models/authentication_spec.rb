require 'spec_helper'

describe Authentication do
  describe '#validation' do
    it 'should check the uniquess of uid-provider' do
      auth = Factory(:facebook)
      user = Factory(:amy)
      user.authentications.build(:uid => auth.uid, :provider => auth.provider)
      user.should_not be_valid
    end
    it 'should check the uniquess of user_id-provider' do
      user = Factory(:amy)
      auth = Factory(:facebook, :user => user)
      user.authentications.build(:uid => '543210987654321', :provider => auth.provider)
      user.should_not be_valid
    end
    it 'should check the presence of user_id' do
      auth = Factory.build(:facebook, :user_id => nil)
      auth.should_not be_valid
    end
  end
end

