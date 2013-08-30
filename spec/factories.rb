FactoryGirl.define do 
  factory :user do
    email 'user1@example.com'
    password 'password1'
    password_confirmation 'password1'
  end
end