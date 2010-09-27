Factory.define :item do |f|
  f.level 0
  f.text '100m'
end

Factory.define :first, :parent => :item do |f|
  f.text '400m'
  f.distance 400
end
Factory.define :second, :parent => :item do |f|
  f.text '2*800m'
  f.distance 800
end
Factory.define :third, :parent => :item do |f|
  f.text '3*500m'
  f.distance 500
end
Factory.define :third_lvl1, :parent => :item do |f|
  f.level 1
  f.text "50m"
  f.distance 50
end

