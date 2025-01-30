# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    company

    trait :manager do
      role { :manager }
    end

    trait :director do
      role { :director }
    end

    trait :executive do
      role { :executive }
    end

    trait :with_subordinates do
      after(:create) do |user|
        create_list(:user, 3, manager: user, company: user.company)
      end
    end
  end
end
