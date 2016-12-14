FactoryGirl.define do
  factory :role do
    title
  end

  sequence :title, (%w[requester professional admin]).cycle do |role|
    role
  end
end
