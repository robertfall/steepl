class CreateFamilyMemberRoles < ActiveRecord::Migration
  def change
    create_table :family_member_roles do |t|
      t.belongs_to :family_role
      t.belongs_to :member

      t.timestamps
    end
    add_index :family_member_roles, :family_role_id
    add_index :family_member_roles, :member_id
  end
end
