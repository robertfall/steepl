class AddMembershipNumberToMember < ActiveRecord::Migration
  def up
    add_column :members, :membership_number, :integer
    execute 'UPDATE members SET membership_number = id'
    execute 'UPDATE members SET id = id + 1027'
    execute 'UPDATE addresses SET member_id = member_id + 1027'
    execute 'UPDATE family_members SET member_id = member_id + 1027'
    execute 'UPDATE group_members SET member_id = member_id + 1027'
    execute 'UPDATE phone_numbers SET member_id = member_id + 1027'
    execute "UPDATE message_recipients SET messageable_id = messageable_id + 1027 WHERE messageable_type = 'Member'"
  end

  def down
    remove_column :members, :membership_number
  end
end
