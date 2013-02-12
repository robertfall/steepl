class DashboardController < ApplicationController
  before_filter :require_login

  def index
    @upcoming_sets = SongSet.upcoming.published
  end
end
