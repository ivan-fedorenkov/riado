#encoding: utf-8

Допустим /^в адвокатской палате "(.*?)" зарегистрирован адвокат "(.*?)" с реестровым номером "(.*?)"$/ do |acol_name, advocate_second_name, advocate_reg_num|
  acol = Acol.find_by_name(acol_name)
  FactoryGirl.create(:advocate, :acol => acol, :second_name => advocate_second_name, :reg_num => advocate_reg_num)
end

Допустим /^я нахожусь на странице адвоката с реестровым номером "(.*?)"$/ do |reg_num|
  advocate = Advocate.find_by_reg_num(reg_num)
  visit(advocate_path(advocate))
end
