module UserPermissions
  def self.included(base)
    base.class_eval do
      alias_method :can, :can?
    end
  end

  def can?(permission)
    @checker ||= UserPermissionChecker.new(self)
    @checker.can_user?(permission)
  end
end
