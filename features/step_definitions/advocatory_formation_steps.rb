#encoding: utf-8

Допустим /^в адвокатской палате "(.*?)" зарегистрировано адвокатское образование "(.*?)"$/ do |acol_name, formation_name|
  acol = Acol.find_by_name!(acol_name)
  FactoryGirl.create(:advocatory_formation, :acol => acol, :name => formation_name)
end

Допустим /^я нахожусь на странице адвокатского образования "(.*?)"$/ do |formation_name|
  formation = AdvocatoryFormation.find_by_name!(formation_name)
  visit(advocatory_formation_path(formation))
end