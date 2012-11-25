#encoding: utf-8

require 'spec_helper'

describe AdvocatesController do
  
  let(:advocate) do
    advocate = double("Адвокат")
    advocate.stub(:id).and_return(id_double)
    advocate
  end
  
  describe "#show" do
    it "Должен установить переменную с информацией об адвокате" do
      Advocate.should_receive(:find).with(advocate.id.to_s).and_return(advocate)
      get 'show', :id => advocate.id
      assigns[:advocate].should eql(advocate)
    end
    it "Должен перенаправить на главную страницу и установить сообщение об ошибке, если адвокат не найден" do
      Advocate.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      get 'show', :id => advocate.id
      response.should redirect_to(root_path)
      flash[:error].should eql("controllers.advocates.flash_messages.advocate_not_found")
    end
  end
end
