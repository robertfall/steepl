class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :email
      t.date   :date_of_birth
      t.date   :joined_on

      t.timestamps
    end
  end
end
