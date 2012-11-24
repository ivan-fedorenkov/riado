#encoding: utf-8

Допустим /^в регионе "(.*?)" существует адвокатская палата "(.*?)"$/ do |region_name, acol_name|
  region = Region.find_by_name!(region_name)
  FactoryGirl.create(:acol, :region => region, :name => acol_name)
end

Допустим /^я нахожусь на странице адвокатской палаты "(.*?)"$/ do |acol_name|
  acol = Acol.find_by_name(acol_name)
  visit(acol_path(acol))
end
