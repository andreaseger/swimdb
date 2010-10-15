Factory.define :comment do |f|
  f.body "awesome schedule"
  f.email "foo@bar.com"
end

Factory.define :name_comment, :parent => :comment do |f|
  f.commenter "hase"
end

