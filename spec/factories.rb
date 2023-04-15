# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    content { 'MyString' }
    user { nil }
  end

  factory :user do
    public_key { '' }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
