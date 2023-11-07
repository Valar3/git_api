# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    uid { '120555889' }
    email { 'balonw@gmail.com' }
    github_access_token { rand(10_000) }
  end
end
