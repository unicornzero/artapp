FactoryGirl.define do 
  factory :space do
    name 'Lawrence Street Gallery'
  end
  factory :user do
    email 'user1@example.com'
    password 'password1'
    password_confirmation 'password1'
  end
end