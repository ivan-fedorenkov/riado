#encoding: utf-8

Допустим /^я нахожусь на главной странице$/ do
  visit(root_path)
end

То /^я должен видеть "(.*?)"$/ do |content|
  page.should have_content(content)
end

То /^я должен видеть "(.*?)" в (.*?)$/ do |content, area|
  selector = WebSupport.selector(area)
  selector.should_not eql(nil), "Заданный селектор '#{area}' не найден. Добавьте его в support/web_support.rb!"
  if selector
    find(selector).should have_content(content)
  end
end
