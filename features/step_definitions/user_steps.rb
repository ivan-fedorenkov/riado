#encoding: utf-8

Допустим /^я нахожусь на странице регистрации$/ do
  visit(new_user_registration_path)
end

Допустим /^я нахожусь на странице входа в учётную запись$/ do
  visit(new_user_session_path)
end

Допустим /^я заполнил необходимые поля формы регистрации нового пользователя$/ do
  fill_in('Email', :with => "user@riado.ru")
  fill_in('Пароль', :with => "password")
  fill_in('Подтверждение', :with => "password")
  click_on('Отправить')
end

Допустим /^я заполнил необходимые поля формы входа в учётную запись$/ do
  fill_in('Email', :with => "user@riado.ru")
  fill_in('Пароль', :with => "password")
  click_on('Войти')
end

Допустим /^существует зарегистрированный пользователь "(.*?)"$/ do |email|
  user = FactoryGirl.create(:user, :email => email)
end




