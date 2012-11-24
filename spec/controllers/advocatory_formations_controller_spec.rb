#encoding: utf-8

require 'spec_helper'

describe AdvocatoryFormationsController do

  let(:advocatory_formation) { FactoryGirl.create(:advocatory_formation) }

  describe "show" do
    it "Должен установить информацию об адвокатском образовании" do
      AdvocatoryFormation.stub(:find).and_return(advocatory_formation)
      get 'show', :id => advocatory_formation.id
      assigns[:advocatory_formation].should eql(advocatory_formation)
    end
    
    it "Должен перенаправить на главную страницу и установить сообщение об ошибке, если образование не найдено" do
      AdvocatoryFormation.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      get 'show', :id => advocatory_formation.id
      response.should redirect_to(root_path)
      flash[:error].should eql("controllers.advocatory_formations.flash_messages.advocatory_formation_not_found")
    end
  end

end
