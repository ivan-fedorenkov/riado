#encoding: utf-8

require 'spec_helper'

describe AcolsController do
  
  let(:acol) do
    
    acol = double("Палата адвокатов")
    acol.stub(:id).and_return(id_double)
    acol.stub(:name).and_return(name_double)
    acol
    
  end

  describe "Отображение информации о палате адвокатов" do
    
    context "Палата адвокатов существует" do
      
      it "Информация об адвокатском образовании должна быть доступна для отображения" do
        Acol.should_receive(:find).and_return(acol)
        get :show, :id => acol.id
        assigns[:acol].should eql(acol)
      end
      
    end
    
    context "Палата адвокатов не существует" do
      it "Должно быть произведено перенаправление на главную страницу и должно быть установлено сообщение об ошибке" do
        Acol.stub(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, :id => acol.id
        flash[:error].should eql("controllers.acols.flash_messages.acol_not_found")
        response.should redirect_to(root_path)  
      end
    end
    
  end

end
