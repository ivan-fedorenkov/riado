#encoding: utf-8

Допустим /^существует регион "(.*?)"( \(по-умолчанию\))?$/ do |region, default|
  region = FactoryGirl.build(:region, :name => region)
  region.default = true if default
  region.save!
end

Допустим /^я выбрал регион "(.*?)"$/ do |region_name|
  region = Region.find_by_name!(region_name)
  visit(set_current_region_path(region))
end

Допустим /^я выбрал несуществующий регион$/ do
  visit(set_current_region_path(:id => -1))  
end 