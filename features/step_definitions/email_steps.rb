#encoding: utf-8

# Commonly used email steps (russian version)
#
# To add your own steps make a custom_email_steps.rb
# The provided methods are:
#
# last_email_address
# reset_mailer
# open_last_email
# visit_in_email
# unread_emails_for
# mailbox_for
# current_email
# open_email
# read_emails_for
# find_email
#
# General form for email scenarios are:
#   - clear the email queue (done automatically by email_spec)
#   - execute steps that sends an email
#   - check the user received an/no/[0-9] emails
#   - open the email
#   - inspect the email contents
#   - interact with the email (e.g. click links)
#
# The Cucumber steps below are setup in this order.

module EmailHelpers
  def current_email_address
    # Replace with your a way to find your current email. e.g @current_user.email
    # last_email_address will return the last email address used by email spec to find an email.
    # Note that last_email_address will be reset after each Scenario.
    last_email_address || @current_user.email
  end
  
  def ru_parse_email_count(amount)
    case amount
    when "одно"
      1
    when "ни одного"
      0
    else
      amount.to_i
    end
  end
  
end

World(EmailHelpers)

#
# Reset the e-mail queue within a scenario.
# This is done automatically before each scenario.
#

Допустим /^(?:очередь писем пуста|не было отправлено ни одного письма)$/ do
  reset_mailer
end

#
# Check how many emails have been sent/received
#

То /^(?:я|они|"([^"]*?)") долж(?:ен|ны) получить (одно|ни одного|\d+) пис(?:ем|ьмо|ьма)$/ do |address, amount|
  unread_emails_for(address).size.should == ru_parse_email_count(amount)
end

То /^(?:я|они|"([^"]*?)") долж(?:ен|ны) иметь (одно|ни одного|\d+) пис(?:ем|ьмо|ьма)$/ do |address, amount|
  mailbox_for(address).size.should == ru_parse_email_count(amount)
end

То /^(?:я|они|"([^"]*?)") долж(?:ен|ны) получить (одно|ни одного|\d+) пис(?:ем|ьмо|ьма) с темой "([^"]*?)"$/ do |address, amount, subject|
  unread_emails_for(address).select { |m| m.subject =~ Regexp.new(Regexp.escape(subject)) }.size.should == ru_parse_email_count(amount)
end

То /^(?:я|они|"([^"]*?)") долж(?:ен|ны) получить (одно|ни одного|\d+) пис(?:ем|ьмо|ьма) с темой \/([^"]*?)\/$/ do |address, amount, subject|
  unread_emails_for(address).select { |m| m.subject =~ Regexp.new(subject) }.size.should == ru_parse_email_count(amount)
end

То /^(?:я|они|"([^"]*?)") долж(?:ен|ны) получить письмо содержащее следующий текст:$/ do |address, expected_body|
  open_email(address, :with_text => expected_body)
end

#
# Accessing emails
#

# Opens the most recently received email
Когда /^(?:я|они|"([^"]*?)") открыва(?:ю|ют|ет) письмо$/ do |address|
  open_email(address)
end

Когда /^(?:я|они|"([^"]*?)") открыва(?:ю|ют|ет) письмо с темой "([^"]*?)"$/ do |address, subject|
  open_email(address, :with_subject => subject)
end

Когда /^(?:я|они|"([^"]*?)") открыва(?:ю|ют|ет) письмо с темой \/([^"]*?)\/$/ do |address, subject|
  open_email(address, :with_subject => Regexp.new(subject))
end

Когда /^(?:я|они|"([^"]*?)") открыва(?:ю|ют|ет) письмо с текстом "([^"]*?)"$/ do |address, text|
  open_email(address, :with_text => text)
end

Когда /^(?:я|они|"([^"]*?)") открыва(?:ю|ют|ет) письмо с текстом \/([^"]*?)\/$/ do |address, text|
  open_email(address, :with_text => Regexp.new(text))
end

#
# Inspect the Email Contents
#

То /^(?:я|они) долж(?:ен|ны) видеть "([^"]*?)" в теме письма$/ do |text|
  current_email.should have_subject(text)
end

То /^(?:я|они) долж(?:ен|ны) видеть \/([^"]*?)\/ в теме письма$/ do |text|
  current_email.should have_subject(Regexp.new(text))
end

То /^(?:я|они) долж(?:ен|ны) видеть "([^"]*?)" в тексте письма$/ do |text|
  current_email.default_part_body.to_s.should include(text)
end

То /^(?:я|они) долж(?:ен|ны) видеть \/([^"]*?)\/ в тексте письма$/ do |text|
  current_email.default_part_body.to_s.should =~ Regexp.new(text)
end

То /^(?:я|они) долж(?:ен|ны) видеть письмо полученное от "([^"]*?)"$/ do |text|
  current_email.should be_delivered_from(text)
end

То /^(?:я|они) долж(?:ен|ны) видеть "([^\"]*)" в заголовке письма "([^"]*?)"$/ do |text, name|
  current_email.should have_header(name, text)
end

То /^(?:я|они) долж(?:ен|ны) видеть \/([^\"]*)\/ в заголовке письма "([^"]*?)"$/ do |text, name|
  current_email.should have_header(name, Regexp.new(text))
end

То /^я должен видеть что письмо типа multipart$/ do
    current_email.should be_multipart
end

То /^(?:я|они) долж(?:ен|ны) видеть "([^"]*?)" в части html тела письма$/ do |text|
    current_email.html_part.body.to_s.should include(text)
end

То /^(?:я|они) долж(?:ен|ны) видеть "([^"]*?)" в текстовой части тела письма$/ do |text|
    current_email.text_part.body.to_s.should include(text)
end

#
# Inspect the Email Attachments
#

То /^(?:я|они) долж(?:ен|ны) видеть (одно|ни одного|\d+) вложени(?:я|й|е) в письмо$/ do |amount|
  current_email_attachments.size.should == ru_parse_email_count(amount)
end

То /^должно быть (одно|ни одного|\d+) вложени(?:я|й|е) с именем "([^"]*?)"$/ do |amount, filename|
  current_email_attachments.select { |a| a.filename == filename }.size.should == ru_parse_email_count(amount)
end

То /^вложение (\d+) должно иметь имя "([^"]*?)"$/ do |index, filename|
  current_email_attachments[(index.to_i - 1)].filename.should == filename
end

То /^должно быть (одно|ни одного|\d+) вложени(?:й|я|е)? типа "([^"]*?)"$/ do |amount, content_type|
  current_email_attachments.select { |a| a.content_type.include?(content_type) }.size.should == ru_parse_email_count(amount)
end

То /^вложение (\d+) должно иметь тип "([^"]*?)"$/ do |index, content_type|
  current_email_attachments[(index.to_i - 1)].content_type.should include(content_type)
end

То /^все вложения не должны быть пустыми$/ do
  current_email_attachments.each do |attachment|
    attachment.read.size.should_not == 0
  end
end

То /^покажи мне список вложений$/ do
  EmailSpec::EmailViewer::save_and_open_email_attachments_list(current_email)
end

#
# Interact with Email Contents
#

Когда /^(?:я|они) перехо(дят|жу) по ссылке "([^"]*?)" в письме$/ do |link|
  visit_in_email(link)
end

Когда /^(?:я|они) перехо(?:дят|жу) по первой ссылке в письме$/ do
  click_first_link_in_email
end

#
# Debugging
# These only work with Rails and OSx ATM since EmailViewer uses RAILS_ROOT and OSx's 'open' command.
# Patches accepted. ;)
#

То /^сохранить и открыть текущее письмо$/ do
  EmailSpec::EmailViewer::save_and_open_email(current_email)
end

То /^сохранить и открыть все текстовые письма$/ do
  EmailSpec::EmailViewer::save_and_open_all_text_emails
end

То /^сохранить и открыть все html письма$/ do
  EmailSpec::EmailViewer::save_and_open_all_html_emails
end

То /^сохранить и открыть все raw письма$/ do
  EmailSpec::EmailViewer::save_and_open_all_raw_emails
end
