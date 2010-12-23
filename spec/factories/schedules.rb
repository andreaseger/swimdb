FactoryGirl.define do
  factory :schedule do
    title "just an test"
    description "jaba jaba jaba"
    taggings "bla foo"
  end

  factory :valid_schedule, :parent => :schedule do
    items [Factory(:first)]
  end

  factory :full_distance_test1, :parent => :schedule do
    items [Factory(:first),
             Factory(:second),
             Factory(:third)]
  end

  factory :full_distance_test2, :parent => :schedule do
    items [Factory(:first),
             Factory(:second),
             Factory(:third),
             Factory(:third_lvl1)]
  end

  factory :full_distance_test3, :parent => :schedule do
    items [Factory(:forth),
             Factory(:forth_lvl2)]
  end

  factory :full_distance_test4, :parent => :schedule do
    items [Factory(:forth),
             Factory(:forth_lvl1)]
  end

  factory :full_distance_test5, :parent => :schedule do
    items [ Factory(:first),
              Factory(:third_lvl1)]
  end

  factory :full_distance_test6, :parent => :schedule do
    items [ Factory(:third),
              Factory(:forth_lvl2)]
  end

  factory :full_distance_test7, :parent => :schedule do
    items [ Factory(:first),
              Factory(:second),
              Factory(:third),
              Factory(:third_lvl1),
              Factory(:forth),
              Factory(:forth_lvl2),
              Factory(:forth_lvl1)]
  end

  factory :full_distance_test7ext, :parent => :schedule do
    items [ Factory(:first),
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

  factory :full_distance_with_info, :parent => :schedule do
    items [Factory(:first),
             Factory(:second),
             Factory(:info),
             Factory(:third),
             Factory(:third_lvl1)]
  end
end

