class AdvocatesController < ApplicationController
  
  def show
    begin
      @advocate = Advocate.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "controllers.advocates.flash_messages.advocate_not_found"
      redirect_to root_path
    end
  end
  
end
