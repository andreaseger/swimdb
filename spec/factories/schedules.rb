Factory.define :schedule do |f|
  f.name "just an test"
  f.description "jaba jaba jaba"
end

Factory.define :full_distance_test, :parent => :schedule do |f|
  f.items [Factory(:first), Factory(:second), Factory(:third), Factory(:third_lvl1)]
end