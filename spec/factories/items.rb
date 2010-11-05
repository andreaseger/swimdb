Factory.define :item do |f|
  f.level 0
  f.text '100m'
end

Factory.define :first, :parent => :item do |f|
  f.text '400m'
end
Factory.define :second, :parent => :item do |f|
  f.text '2*800m'
end
Factory.define :third, :parent => :item do |f|
  f.text '3*500m'
end
Factory.define :third_lvl1, :parent => :item do |f|
  f.level 1
  f.text "50m"
end
Factory.define :forth, :parent => :item do |f|
  f.text '3*5*100m'
end
Factory.define :forth_lvl2, :parent => :item do |f|
  f.level 2
  f.text "50m"
end
Factory.define :forth_lvl1, :parent => :item do |f|
  f.level 1
  f.text "2x50m"
end
Factory.define :info, :parent => :item do |f|
  f.text "=> foo"
end

