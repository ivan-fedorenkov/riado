class AcolsController < ApplicationController
  
  def show
    begin
      @acol = Acol.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "controllers.acols.flash_messages.acol_not_found"
      redirect_to root_path
    end
  end

end
