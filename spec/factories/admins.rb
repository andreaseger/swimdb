FactoryGirl.define do
  factory :alice, :class => :admin do
    email "alice@foo.com"
    password "secret"
    password_confirmation "secret"
  end
end

