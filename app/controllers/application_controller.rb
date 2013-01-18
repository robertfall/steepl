class ApplicationController < ActionController::Base
  helper_method :current_song_set
  protect_from_forgery

  def current_song_set
    @current_song_set ||= SongSet.find(session[:song_set_id]) if session[:song_set_id]
  end

  def current_song_set=(song_set)
    session[:song_set_id] = song_set.id
  end

  def worship_leader_only
    unless current_user and current_user.worship_leader?
      flash[:error] = "Sorry. Only team leaders can access this page."
      redirect_to root_path
    end
  end

  protected
  def not_authenticated
    redirect_to login_path, :alert => "Please login first."
  end
end
