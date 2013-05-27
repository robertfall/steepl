class AddUserAndWorshipPermissions < ActiveRecord::Migration
  def up
    user_edit = Permission.create name: 'Edit Users',
      key: 'edit_users',
      description: 'Create, edit and delete users as well as user roles and permisions'

    user_read = Permission.create name: 'Read Users',
      key: 'read_users',
      description: 'Read users and roles'

    worship_read = Permission.create name: 'Read Worship',
      key: 'read_worship',
      description: 'Read songs and sets for worship'

    worship_edit = Permission.create name: 'Edit Worship',
      key: 'edit_worship',
      description: 'Create, edit and delete Songs and Sets'


    Role.create name: 'Worship Member',
      description: 'Basic access to songs and sets',
      permissions: [worship_read]

    Role.create name: 'Worship Leader',
      description: 'Can create and edit songs and sets',
      permissions: [worship_read, worship_edit]

    Role.create name: 'User Clerk',
      description: 'Can read users and permissions',
      permissions: [user_read]

    Role.create name: 'User Admin',
      description: 'Can create, update and delete users and roles',
      permissions: [user_read, user_edit]
  end

  def down
    Permission.where(key: ['edit_worship', 'read_worship', 'edit_users', 'read_users']).map &:delete

    ['Worship Member', 'Worship Leader', 'User Clerk', 'User Admin'].each do |role|
      Role.find_by_name(role).delete
    end
  end
end
