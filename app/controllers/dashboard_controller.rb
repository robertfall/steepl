class DashboardController < ApplicationController
  before_filter :require_login

  def worship
    @module = :worship
    @upcoming_sets = SongSet.upcoming.published.includes(songs: :attachments)
  end
end
