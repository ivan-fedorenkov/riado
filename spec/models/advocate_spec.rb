#encoding: utf-8

require 'spec_helper'

describe Advocate do
  
  let(:advocate) do
    FactoryGirl.create(:advocate)
  end
  
  
  
  describe "Валидация" do
    
    describe "Адвокатская палата" do
      it "Должна быть указанна" do
        create_should_raise_record_invalid(:advocate, :acol => nil)
      end
    end

    describe "Статус" do
      it "Не может быть пустым" do
        create_should_raise_record_invalid(:advocate, :status => nil)
      end
      
      it "Не должен быть отличен от заданного списка значений" do
        create_should_raise_record_invalid(:advocate, :status => :invalid_status)
      end
    end
    
    describe "Реестровый номер" do
      it "Не может быть пустым" do
        create_should_raise_record_invalid(:advocate, :reg_num => nil)
      end
      it "Уникальный реестровый номер" do
        create_should_raise_record_invalid(:advocate, :reg_num => advocate.reg_num)
      end
      it "Должен быть в заданном формате" do
        create_should_raise_record_invalid(:advocate, :reg_num => "invalid/format")
      end
    end
    
    describe "Пол" do
      it "Не должен быть отличен от заданного списка значений" do
        create_should_raise_record_invalid(:advocate, :sex => :invalid_sex)
      end
    end
    
    describe "Адвокатское образование" do
      
      let(:advocatory_formation) do
        advocatory_formation = double("Адвокатское образование")
        advocatory_formation.stub(:id).and_return(id_double)
        advocatory_formation.stub(:advocates).and_return([double("Адвокат 1"), double("Адвокат 2")])
        advocatory_formation
      end
      
      it "Методы установки адвокатского образования должны быть закрыты" do
        advocate.respond_to?(:advocatory_formation=).should_not be_true 
        advocate.respond_to?(:advocatory_formation_id=).should_not be_true
      end

    end
        
  end
  
end
