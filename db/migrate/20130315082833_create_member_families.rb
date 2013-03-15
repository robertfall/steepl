class CreateMemberFamilies < ActiveRecord::Migration
  def change
    create_table :member_families do |t|
      t.integer :member_id
      t.integer :family_id

      t.timestamps
    end
  end
end
