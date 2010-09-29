Factory.define :schedule do |f|
  f.name "just an test"
  f.description "jaba jaba jaba"
end

Factory.define :full_distance_test1, :parent => :schedule do |f|
  f.items [Factory(:first),
           Factory(:second, :rank => 1),
           Factory(:third, :rank => 2)]
end
Factory.define :full_distance_test2, :parent => :schedule do |f|
  f.items [Factory(:first),
           Factory(:second, :rank => 1),
           Factory(:third, :rank => 2),
           Factory(:third_lvl1, :rank => 3)]
end

Factory.define :full_distance_test3, :parent => :schedule do |f|
  f.items [Factory(:forth),
           Factory(:forth_lvl2, :rank => 1)]
end

Factory.define :full_distance_test4, :parent => :schedule do |f|
  f.items [Factory(:forth),
           Factory(:forth_lvl1, :rank => 1)]
end

Factory.define :full_distance_test5, :parent => :schedule do |f|
  f.items [ Factory(:first),
            Factory(:third_lvl1, :rank => 1)]
end

Factory.define :full_distance_test6, :parent => :schedule do |f|
  f.items [ Factory(:third),
            Factory(:forth_lvl2, :rank => 1)]
end

Factory.define :full_distance_test7, :parent => :schedule do |f|
  f.items [ Factory(:first),
            Factory(:second, :rank => 1),
            Factory(:third, :rank => 2),
            Factory(:third_lvl1, :rank => 3),
            Factory(:forth, :rank => 4),
            Factory(:forth_lvl2, :rank => 5),
            Factory(:forth_lvl1, :rank => 6)]
end
Factory.define :full_distance_test7ext, :parent => :schedule do |f|
  f.items [ Factory(:first),
            Factory(:second, :rank => 1),
            Factory(:third, :rank => 2),
            Factory(:third_lvl1, :rank => 3),
            Factory(:forth, :rank => 4),
            Factory(:forth_lvl2, :rank => 5),
            Factory(:forth_lvl1, :rank => 6),
            Factory(:third, :rank => 7),
            Factory(:forth_lvl2, :rank => 8),
            Factory(:first, :rank => 9),
            Factory(:third_lvl1, :rank => 10)]
end

