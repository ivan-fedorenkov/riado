# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user{n}@riado.ru" }
    password "password"
    password_confirmation "password"
  end
end
