#encoding: utf-8

Допустим /^база данных заполнена начальными данными$/ do
  load Rails.root + "db/seeds.rb"
end
