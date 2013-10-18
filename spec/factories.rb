FactoryGirl.define do 
  factory :space do
    sequence(:name) { |n| "Gallery No. #{n}" }
    sequence(:url) { |n| "http://www.gallery#{n}.com" }
  end
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password1'
    password_confirmation { |u| u.password }
  end
  factory :subscription do
    plan 'Basic'
  end
  factory :owned_space, class: Space do
    name 'Awesome Gallery'
    url 'http://www.awesomegallery.com'
    user
    association :subscription
  end
  factory :owned_subscription, class: Subscription do
    plan 'Basic'
    association :user
    association :space
    after(:build) do |sub|
      sub.space.user_id = sub.user.id
      sub.space.save
    end
  end
  factory :pro_subscription, class: Subscription do
    plan 'Pro'
    stripe_cust_id 's_cust_123456'
    association :user
    association :space
    after(:build) do |sub|
      sub.space.user_id = sub.user.id
      sub.space.save
    end
  end
end