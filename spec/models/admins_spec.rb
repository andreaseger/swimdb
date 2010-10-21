require 'spec_helper'

describe Admin do
  describe 'when validate' do
    it 'should check presence of email' do
      user = Factory.build(:alice, :email => nil)
      user.should_not be_valid
    end
    it 'should check uniquess of the email' do
      Factory(:alice)
      user = Factory.build(:alice, :username => "Frank")
      user.should_not be_valid
    end
  end

end

