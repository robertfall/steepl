class AddWorshipLeaderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :worship_leader, :boolean
  end
end
