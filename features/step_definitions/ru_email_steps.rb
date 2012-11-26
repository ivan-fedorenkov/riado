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
    last_email_address || "example@example.com"
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

То /^(?:Я|Они|"([^"]*?)") долж(ен|ны) получить (одно|ни одного|\d+) писем(о|а)?$/ do |address, trash1, amount, trash2|
  unread_emails_for(address).size.should == ru_parse_email_count(amount)
end

То /^(?:Я|Они|"([^"]*?)") долж(ен|ны) иметь (одно|ни одного|\d+) писем(о|а)?$/ do |address, trash1, amount, trash2|
  mailbox_for(address).size.should == ru_parse_email_count(amount)
end

То /^(?:Я|Они|"([^"]*?)") долж(ен|ны) получить (одно|ни одного|\d+) писем(о|а)? с темой "([^"]*?)"$/ do |address, trash1, amount, trash2, subject|
  unread_emails_for(address).select { |m| m.subject =~ Regexp.new(Regexp.escape(subject)) }.size.should == ru_parse_email_count(amount)
end

То /^(?:Я|Они|"([^"]*?)") долж(ен|ны) получить (одно|ни одного|\d+) писем(о|а)? с темой \/([^"]*?)\/$/ do |address, trash1, amount, trash2, subject|
  unread_emails_for(address).select { |m| m.subject =~ Regexp.new(subject) }.size.should == ru_parse_email_count(amount)
end

То /^(?:Я|Они|"([^"]*?)") долж(ен|ны) получить письмо содержащее следующий текст:$/ do |address, trash1, expected_body|
  open_email(address, :with_text => expected_body)
end

#
# Accessing emails
#

# Opens the most recently received email
Когда /^(?:Я|Они|"([^"]*?)") открываю?т? письмо$/ do |address|
  open_email(address)
end

Когда /^(?:Я|Они|"([^"]*?)") открываю?т? письмо с темой "([^"]*?)"$/ do |address, subject|
  open_email(address, :with_subject => subject)
end

Когда /^(?:Я|Они|"([^"]*?)") открываю?т? письмо с темой \/([^"]*?)\/$/ do |address, subject|
  open_email(address, :with_subject => Regexp.new(subject))
end

Когда /^(?:Я|Они|"([^"]*?)") открываю?т? письмо с текстом "([^"]*?)"$/ do |address, text|
  open_email(address, :with_text => text)
end

Когда /^(?:Я|Они|"([^"]*?)") открываю?т? письмо с текстом \/([^"]*?)\/$/ do |address, text|
  open_email(address, :with_text => Regexp.new(text))
end

#
# Inspect the Email Contents
#

То /^(?:Я|Они) должен(ы)? видеть "([^"]*?)" в теме письма$/ do |text, trash1|
  current_email.should have_subject(text)
end

То /^(?:Я|Они) должен(ы)? видеть \/([^"]*?)\/ в теме письма$/ do |text, trash1|
  current_email.should have_subject(Regexp.new(text))
end

То /^(?:Я|Они) должен(ы)? видеть "([^"]*?)" в тексте письма$/ do |text, trash1|
  current_email.default_part_body.to_s.should include(text)
end

То /^(?:Я|Они) должен(ы)? видеть \/([^"]*?)\/ в тексте письма$/ do |text, trash1|
  current_email.default_part_body.to_s.should =~ Regexp.new(text)
end

То /^(?:Я|Они) должен(ы)? видеть письмо полученное от "([^"]*?)"$/ do |text, trash1|
  current_email.should be_delivered_from(text)
end

То /^(?:Я|Они) должен(ы)? видеть "([^\"]*)" в заголовке письма "([^"]*?)"$/ do |text, trash1, name|
  current_email.should have_header(name, text)
end

То /^(?:Я|Они) должен(ы)? видеть \/([^\"]*)\/ в заголовке письма "([^"]*?)"$/ do |text, trash1, name|
  current_email.should have_header(name, Regexp.new(text))
end

То /^Я должен(ы)? видеть что письмо типа multipart$/ do
    current_email.should be_multipart
end

То /^(?:Я|Они) должен(ы)? видеть "([^"]*?)" в части html тела письма$/ do |text, trash1|
    current_email.html_part.body.to_s.should include(text)
end

То /^(?:Я|Они) должен(ы)? видеть "([^"]*?)" в текстовой части тела письма$/ do |text, trash1|
    current_email.text_part.body.to_s.should include(text)
end

#
# Inspect the Email Attachments
#

То /^(?:Я|Они) должен(ы)? видеть (одно|ни одного|\d+) вложени(я|й|е) в письмо$/ do |trash1, trash2, amount, trash3|
  current_email_attachments.size.should == ru_parse_email_count(amount)
end

То /^должно быть (одно|ни одного|\d+) вложени(я|й|)? с именем "([^"]*?)"$/ do |amount, trash1, filename|
  current_email_attachments.select { |a| a.filename == filename }.size.should == ru_parse_email_count(amount)
end

То /^вложение (\d+) должно иметь имя "([^"]*?)"$/ do |index, filename|
  current_email_attachments[(index.to_i - 1)].filename.should == filename
end

То /^должно быть (одно|ни одного|\d+) вложени(й|я|)? типа "([^"]*?)"$/ do |amount, trash1, content_type|
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

Когда /^(?:Я|Они) переходят по ссылке "([^"]*?)" в письме$/ do |link|
  visit_in_email(link)
end

Когда /^(?:Я|Они) переходят по первой ссылке в письме$/ do
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
