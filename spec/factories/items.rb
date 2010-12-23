FactoryGirl.define do
  factory :item, :default_strategy => :build do
    level 0
    text '100m'
  end

  factory :first, :parent => :item do
    text '400m'
  end
  factory :second, :parent => :item do
    text '2*800m'
  end
  factory :third, :parent => :item do
    text '3*500m'
  end
  factory :third_lvl1, :parent => :item do
    level 1
    text "50m"
  end
  factory :forth, :parent => :item do
    text '3*5*100m'
  end
  factory :forth_lvl2, :parent => :item do
    level 2
    text "50m"
  end
  factory :forth_lvl1, :parent => :item do
    level 1
    text "2x50m"
  end
  factory :info, :parent => :item do
    text "=> foo"
  end
end

