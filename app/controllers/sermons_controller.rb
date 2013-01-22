class SermonsController < ApplicationController
  respond_to :json
  def index
    @sermons = Sermon.all
    respond_with @sermons
  end

  def create
    @sermon = Sermon.create_from_params(params[:sermon])
    @sermon.save
    respond_with @sermon
  end
end
