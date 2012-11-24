#encoding: utf-8

require 'spec_helper'

describe ApplicationController do
  
  controller do
    def index
      render :text => "index called"
    end
  end
  
  describe 'Фильтры' do

    describe 'Фильтр установки списка регионов' do
      it 'Должен установить список регионов' do
        regions = double('Список регионов') 
        Region.should_receive(:all).and_return(regions)
        get :index
        assigns[:regions].should == regions
      end
    end

    describe 'Фильтр установки текущего региона' do
      
      let(:region) do 
        region = double('Текущий регион')
        region.stub(:id).and_return(id_double)
        region 
      end
      
      it 'Должен взять текущий регион из сессиии' do
        session[:current_region] = region
        get :index
        assigns[:current_region].should == region
      end
      it 'Должен взять регион из куки если сессия не содержит текущего региона' do
        request.cookies['current_region_id'] = region.id
        Region.should_receive(:find).with(region.id).and_return(region)
        get :index
        assigns[:current_region].should == region
      end
      it 'Должен взять регион по-умолчанию если ни сессия, ни куки не содержат региона' do
        default_region = double('Регион по-умолчанию')
        Region.should_receive(:default).and_return(default_region)
        get :index
        assigns[:current_region].should == default_region
      end
    end

  end

end
