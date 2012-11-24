require 'faker'

FactoryGirl.define do
  factory :advocate, :class => 'Advocate' do
    second_name { Faker::Name.name }
    first_name { Faker::Name.name }
    patronomic { Faker::Name.name }
    sequence(:reg_num) { |n| "01/#{n}" } 
    status :active
    sex :male
    
    acol
  end
end
