Factory.define :alice, :class => :admin do |f|
  f.email "alice@foo.com"
  f.password "secret"
  f.password_confirmation "secret"
end

