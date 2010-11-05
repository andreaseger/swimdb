Factory.define :schedule do |f|
  f.name "just an test"
  f.description "jaba jaba jaba"
  #f.items [Factory(:first)]
end

Factory.define :valid_schedule, :parent => :schedule do |f|
  f.items [Factory(:first)]
end

Factory.define :full_distance_test1, :parent => :schedule do |f|
  f.items [Factory(:first),
           Factory(:second),
           Factory(:third)]
end

Factory.define :full_distance_test2, :parent => :schedule do |f|
  f.items [Factory(:first),
           Factory(:second),
           Factory(:third),
           Factory(:third_lvl1)]
end

Factory.define :full_distance_test3, :parent => :schedule do |f|
  f.items [Factory(:forth),
           Factory(:forth_lvl2)]
end

Factory.define :full_distance_test4, :parent => :schedule do |f|
  f.items [Factory(:forth),
           Factory(:forth_lvl1)]
end

Factory.define :full_distance_test5, :parent => :schedule do |f|
  f.items [ Factory(:first),
            Factory(:third_lvl1)]
end

Factory.define :full_distance_test6, :parent => :schedule do |f|
  f.items [ Factory(:third),
            Factory(:forth_lvl2)]
end

Factory.define :full_distance_test7, :parent => :schedule do |f|
  f.items [ Factory(:first),
            Factory(:second),
            Factory(:third),
            Factory(:third_lvl1),
            Factory(:forth),
            Factory(:forth_lvl2),
            Factory(:forth_lvl1)]
end

Factory.define :full_distance_test7ext, :parent => :schedule do |f|
  f.items [ Factory(:first),
            Factory(:second),
            Factory(:third),
            Factory(:third_lvl1),
            Factory(:forth),
            Factory(:forth_lvl2),
            Factory(:forth_lvl1),
            Factory(:third),
            Factory(:forth_lvl2),
            Factory(:first),
            Factory(:third_lvl1)]
end

Factory.define :full_distance_with_info, :parent => :schedule do |f|
  f.items [Factory(:first),
           Factory(:second),
           Factory(:info),
           Factory(:third),
           Factory(:third_lvl1)]
end

