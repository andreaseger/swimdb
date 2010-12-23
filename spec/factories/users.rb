FactoryGirl.define do
  factory :bob, :class => :user do
    username "Bob"
    email "bob@foo.com"
    password "secret"
    password_confirmation "secret"
  end

  factory :amy, :class => :user do
    username "Amy"
    email "amy@foo.com"
    password "secret"
    password_confirmation "secret"
  end
end

