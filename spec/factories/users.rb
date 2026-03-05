# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # Use a sequence for unique emails
    sequence(:email) { |n| "user#{n}@example.com" }
    
    password { "password123" }
    password_confirmation { "password123" }

    role { :viewer }  # default

    trait :viewer do
      role { :viewer }
    end

    trait :editor do
      role { :editor }
    end

    trait :admin do
      role { :admin }
    end
  end
end