#encoding: utf-8

require 'spec_helper'

describe Region do
  describe "Валидация" do
    describe "Название" do
      it "Должно не быть пустым" do
        create_should_raise_record_invalid(:region, :name => nil)
      end
    end
  end
end
