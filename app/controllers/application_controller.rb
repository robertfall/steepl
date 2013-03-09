class ApplicationController < ActionController::Base
  COLORS = %w{green red blue deep-blue}
  protect_from_forgery
  before_filter :choose_color
  before_filter :set_module
  before_filter :enable_profiling

  def worship_leader_only
    unless current_user and current_user.worship_leader?
      flash[:error] = "Sorry. Only team leaders can access this page."
      redirect_to root_path
    end
  end

  def choose_color
    @color = METRO_COLORS.keys.sample
  end

  def self.part_of(module_symbol)
    @module = module_symbol.to_s
    class << self; attr_reader :module; end
  end

  protected
  def not_authenticated
    redirect_to login_path, :alert => "Please login first."
  end

  def set_module
    @module = self.class.module if self.class.respond_to?(:module)
  end

  def enable_profiling
    if current_user and current_user.worship_leader?
      Rack::MiniProfiler.authorize_request
    end
  end
end
