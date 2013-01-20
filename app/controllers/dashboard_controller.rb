class DashboardController < ApplicationController
  def index
    @latest_set = SongSet.latest
  end
end
