Factory.define :schedule do |f|
  f.name "just an test"
  f.description "jaba jaba jaba"
  #f.items [Factory(:first)]
end

Factory.define :valid_schedule, :parent => :schedule do |f|
  f.items [Factory.build(:first)]
end

Factory.define :full_distance_test1, :parent => :schedule do |f|
  f.items [Factory.build(:first),
           Factory.build(:second),
           Factory.build(:third)]
end
Factory.define :full_distance_test2, :parent => :schedule do |f|
  f.items [Factory.build(:first),
           Factory.build(:second),
           Factory.build(:third),
           Factory.build(:third_lvl1)]
end

Factory.define :full_distance_test3, :parent => :schedule do |f|
  f.items [Factory.build(:forth),
           Factory.build(:forth_lvl2)]
end

Factory.define :full_distance_test4, :parent => :schedule do |f|
  f.items [Factory.build(:forth),
           Factory.build(:forth_lvl1)]
end

Factory.define :full_distance_test5, :parent => :schedule do |f|
  f.items [ Factory.build(:first),
            Factory.build(:third_lvl1)]
end

Factory.define :full_distance_test6, :parent => :schedule do |f|
  f.items [ Factory.build(:third),
            Factory.build(:forth_lvl2)]
end

Factory.define :full_distance_test7, :parent => :schedule do |f|
  f.items [ Factory.build(:first),
            Factory.build(:second),
            Factory.build(:third),
            Factory.build(:third_lvl1),
            Factory.build(:forth),
            Factory.build(:forth_lvl2),
            Factory.build(:forth_lvl1)]
end
Factory.define :full_distance_test7ext, :parent => :schedule do |f|
  f.items [ Factory.build(:first),
            Factory.build(:second),
            Factory.build(:third),
            Factory.build(:third_lvl1),
            Factory.build(:forth),
            Factory.build(:forth_lvl2),
            Factory.build(:forth_lvl1),
            Factory.build(:third),
            Factory.build(:forth_lvl2),
            Factory.build(:first),
            Factory.build(:third_lvl1)]
end

