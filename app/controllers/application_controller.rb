class ApplicationController < ActionController::Base
  protect_from_forgery

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
