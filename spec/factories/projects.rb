FactoryGirl.define do
  factory :project do
    name {generate(:project_name)}
    status "unassigned"
    user

    trait :with_skills do
      after(:create) do |project, skill|
        project.skills << skill
        project.save
      end
    end
  end

  sequence :project_name do |n|
    "ProjectName#{n}"
  end
end
