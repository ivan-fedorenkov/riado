require 'faker'

FactoryGirl.define do
  factory :acol do
    name { Faker::Name.name }
    
    region
  end
end
