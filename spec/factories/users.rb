FactoryGirl.define do
  factory :user do
    status "active"
    name
    username
    location
    email
    phone
    password_digest
  end
end
