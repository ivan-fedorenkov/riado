#encoding: utf-8

require 'spec_helper'

describe Acol do
  
  let(:acol) { FactoryGirl.create(:acol) }
  
  describe "Валидация" do
    describe "Название" do
      it "Должно не быть пустым" do
        create_should_raise_record_invalid(:acol, :name => nil)
      end
    end
  end
  
  describe "Методы" do
    describe "#to_s" do
      it "Должен возвращать название адвокатской палаты" do
        acol.to_s.should eql(acol.name)
      end
    end
  end  
  
end
