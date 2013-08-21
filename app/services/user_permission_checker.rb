class UserPermissionChecker
  def initialize(user)
    @user = user
  end

  def can_user?(permission)
    @roles ||= @user.roles
    return true if @roles.any? { |role| role.name == 'Administrator' }
    permissions = @roles.includes(:permissions).map do |role|
      role.permissions.map do |p|
        p.key.to_sym
      end
    end.flatten
    permissions.include?(permission.to_sym)
  end
end
