FactoryGirl.define do
  factory :skill do
    name {generate(:skill_name)}
  end

  sequence :skill_name, (%w[bricklaying snuggling shepherding training]).cycle do |skill|
    skill
  end
end
