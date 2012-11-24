#encoding: utf-8

require 'spec_helper'

describe RegionsController do

  describe 'Смена текущего региона' do
    
    let(:region) { 
      region = double("Регион")
      region.stub(:id).and_return(id_double)
      region.stub(:name).and_return(name_double)
      region
    }
    
    context 'Запрашиваемый регион существует' do

      it 'Должен произвести поиск региона по заданному идентификатору и 
          сохранить текущий регион в сессию, куки и переменную текущего региона' do

        Region.should_receive(:find).with(region.id.to_s).and_return(region)
        get :set_current, :id => region.id
        response.cookies['current_region_id'].should eq(region.id.to_s)
        session[:current_region].should eql(region)
        assigns[:current_region].should eql(region)
      end

    end

    context 'Запрашиваемый регион не существует' do

      it 'Должен быть установлен регион по-умолчанию' do
        Region.should_receive(:find).and_raise(ActiveRecord::RecordNotFound)
        Region.should_receive(:default).and_return(region)
        get :set_current, :id => region.id
        assigns[:current_region].should eql(region)
      end
      
    end

  end

end
