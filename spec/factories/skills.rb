FactoryGirl.define do
  factory :skill do
    name
  end

  sequence :name, (%w[bricklaying snuggling shepherding training]).cycle do |skill|
    skill 
  end
end
