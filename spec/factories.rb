# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    public_key { Faker::String.random }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
