# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    company

    trait :employee do
      role { :employee }
    end

    trait :manager do
      role { :manager }
    end

    trait :with_subordinates do
      after(:create) do |user|
        create_list(:user, 3, manager: user, company: user.company)
      end
    end
  end
end
