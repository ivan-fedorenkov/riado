class AdvocatoryFormationsController < ApplicationController
  
  def show
    begin
      @advocatory_formation = AdvocatoryFormation.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "controllers.advocatory_formations.flash_messages.advocatory_formation_not_found"
      redirect_to root_path
    end
  end

end
