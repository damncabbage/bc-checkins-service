class CheckinsController < ApplicationController
  respond_to :html, :json

  def index
    @checkins = Checkin.all
  end

  def create
    checkin_params = params.require(:checkin)
                           .permit(:order_id, :product_id)
    @checkin = Checkin.create(checkin_params[:checkin])
    respond_with(@checkin) do |f|
      f.html { redirect_to :stream }
      f.json { render :none, :status => :ok }
    end
  end

end
