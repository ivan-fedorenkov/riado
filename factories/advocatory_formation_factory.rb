require 'faker'

FactoryGirl.define do
  factory :advocatory_formation, :class => "AdvocatoryFormation" do
    name { Faker::Name.name }
    form :college
    acol 
  end
end
