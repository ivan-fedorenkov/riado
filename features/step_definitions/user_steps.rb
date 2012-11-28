#encoding: utf-8

Допустим /^существует зарегистрированный пользователь "(.*?)"$/ do |email|
  @current_user = FactoryGirl.create(:user, :email => email)
end

Допустим /^я являюсь этим пользователем$/ do
end

Допустим /^я являюсь пользователем "(.*?)"$/ do |email|
  @current_user = User.find_by_email(email)
end

# Страницы

Допустим /^я нахожусь на странице регистрации$/ do
  visit(new_user_registration_path)
end

Допустим /^я нахожусь на странице входа в учётную запись$/ do
  visit(new_user_session_path)
end

Допустим /^я нахожусь на странице возврата пароля$/ do
  visit(new_user_password_path)
end

# Формы

Допустим /^я заполнил необходимые поля формы регистрации нового пользователя(?: "(.*)")?$/ do |email|
  if email
    user = FactoryGirl.build(:user, :email => email)
  else
    user = FactoryGirl.build(:user)
  end
    
  fill_in('Email', :with => user.email)
  fill_in('Пароль', :with => user.password)
  fill_in('Подтверждение', :with => user.password)
  click_on('Отправить')
end

Допустим /^я заполнил необходимые поля формы входа в учётную запись$/ do
  
  fill_in('Email', :with => @current_user.email)
  fill_in('Пароль', :with => @current_user.password)
  click_on('Войти')
end

Допустим /^я заполнил необходимые поля формы возврата пароля$/ do
  fill_in('Email', :with => @current_user.email)
  click_on('Отправить мне инструкции по смене пароля')
end

Допустим /^я некорректно заполнил поля формы входа в учётную запись$/ do
  fill_in('Email', :with => "incorrect@riado.ru")
  fill_in('Пароль', :with => "incorrect")
  click_on('Войти')
end

Допустим /^я заполнил необходимые поля формы смены пароля$/ do
  fill_in('Новый пароль', :with => "new_password")
  fill_in('Подтверждение', :with => "new_password")
  click_on('Сменить пароль')
end




