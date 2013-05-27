class ApplicationController < ActionController::Base
  COLORS = %w{green red blue deep-blue}
  protect_from_forgery
  before_filter :choose_color
  before_filter :set_module

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

  def authorize(permission)
    return not_authorised(permission) unless current_user.can?(permission)
  end

  protected
  def not_authenticated
    redirect_to login_path, :alert => "Please login first."
  end

  def not_authorised(permission=nil)
    message = (permission and permission.to_s.gsub('_',' ')) || "use this function"
    redirect_to request.referrer || root_path, flash: { error: "You are not authorised to #{message}." }
  end

  def set_module
    @module = self.class.module if self.class.respond_to?(:module)
  end
end
