FactoryGirl.define do
  factory :rating do
    score 5.0
    comment "good comment"
    user {create(:user)}
    giver {create(:giver)}
  end
end
