Factory.define :facebook, :class => :authentication do |f|
  f.uid '123456789012345'
  f.provider 'facebook'
  f.user { Factory(:bob) }
end
Factory.define :twitter, :class => :authentication do |f|
  f.uid '123456789012345'
  f.provider 'twitter'
  f.user { Factory(:bob) }
end

