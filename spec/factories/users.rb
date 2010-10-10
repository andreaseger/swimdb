Factory.define :bob, :class => :user do |f|
  f.username "Bob"
  f.email "bob@foo.com"
  f.password "secret"
  f.password_confirmation "secret"
end

Factory.define :amy, :class => :user do |f|
  f.username "Amy"
  f.email "amy@foo.com"
  f.password "secret"
  f.password_confirmation "secret"
end

