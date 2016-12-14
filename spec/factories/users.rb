FactoryGirl.define do
  factory :user do
    status "active"
    name
    username
    location "Denver"
    email
    phone "555-555-5555"
    password "password"
  end

  sequence :name do |n|
     "Name#{n}"
  end

  sequence :username do |n|
    "Username#{n}"
  end

  sequence :email do |n|
    "test#{n}@example.com"
  end
 
end
