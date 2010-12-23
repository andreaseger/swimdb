FactoryGirl.define do
  factory :facebook, :class => :authentication do
    uid '123456789012345'
    provider 'facebook'
    user { Factory(:bob) }
  end
  factory :twitter, :class => :authentication do
    uid '123456789012345'
    provider 'twitter'
    user { Factory(:bob) }
  end
end

