module Sorcery
  class FreeAuth
    include Controller

    def initialize(request)
      @request = request
    end

    def session
      @session ||= @request.session
    end

    def cookies
      @cookies ||= ActionDispatch::Cookies::CookieJar.build(@request)
    end
  end

  def self.with_request(request)
    yield(FreeAuth.new(request)) if block_given?
  end
end

class PermissionConstraint
  def initialize(permission)
    @permission = permission
  end

  def matches?(request)
    Sorcery.with_request(request) do |c|
      return unless c.current_user
      c.current_user.can?(@permission)
    end
  end
end
