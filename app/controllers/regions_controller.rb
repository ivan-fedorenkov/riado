class RegionsController < ApplicationController
  def set_current
    begin
      @current_region = Region.find(params[:id])
      session[:current_region] = @current_region
      cookies[:current_region_id] = @current_region.id
    rescue ActiveRecord::RecordNotFound
      @current_region = Region.default
    end
    
    redirect_to root_path
  end

end
