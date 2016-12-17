FactoryGirl.define do
  factory :project do
    name {generate(:project_name)}
    status "unassigned"
    user
  end

  sequence :project_name do |n|
    "ProjectName#{n}" 
  end
end
