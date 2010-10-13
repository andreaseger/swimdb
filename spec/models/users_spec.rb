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

end

