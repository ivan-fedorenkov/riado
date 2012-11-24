class ApplicationController < ActionController::Base
  before_filter :set_regions
  before_filter :set_current_region
  
  protect_from_forgery
  
  def index
    render 'main_page/index'
  end

private
  def set_current_region
    if !(request.fullpath =~ /regions\/.*\/set_current/)
      if session[:current_region]
        @current_region = session[:current_region]
      elsif cookies[:current_region_id]
        @current_region = Region.find(cookies[:current_region_id])
      else
        @current_region = Region.default
      end
    end
  end

  def set_regions
    @regions = Region.all
  end
end
