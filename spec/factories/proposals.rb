FactoryGirl.define do
  factory :proposal do
    user {create(:user)}
    project {create(:project)}
  end
end
