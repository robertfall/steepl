class SermonsController < ApplicationController
  respond_to :json
  def index
    @sermons = params[:year] ? Sermon.for_year(params[:year]) : Sermon.all
    respond_with @sermons
  end

  def create
    @sermon = Sermon.create_from_params(params[:sermon])
    @sermon.save
    respond_with @sermon
  end

  def downloaded
    @sermon = Sermon.find(params[:id])
    @sermon.increment_play_count!
    respond_with(@sermon)
  end
end
