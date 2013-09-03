FactoryGirl.define do 
  factory :space do
    sequence(:name) {|n| "Gallery No. #{n}" }
  end
  factory :user do
    email 'user1@example.com'
    password 'password1'
    password_confirmation 'password1'
  end
end