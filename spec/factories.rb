FactoryGirl.define do 
  factory :space do
    sequence(:name) { |n| "Gallery No. #{n}" }
    sequence(:url) { |n| "http://www.gallery#{n}.com" }
  end
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password1'
    password_confirmation 'password1'
  end
end