class CreateMemberPermissions < ActiveRecord::Migration
  def up
    permissions = [Permission.create(name: 'Edit Members', key: 'edit_members', description: 'Create, Delete and Edit Members'),
      Permission.create(name: 'Read Members', key: 'read_members', description: 'Read Members')]

    Role.create(name: 'Members Clerk', description: 'Basic access to members', permissions: permissions)
  end

  def down
    Permission.where(key: ['read_members']).map &:delete
  end
end
