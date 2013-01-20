class DashboardController < ApplicationController
  before_filter :require_login

  def index
    @latest_set = SongSet.latest
  end
end
