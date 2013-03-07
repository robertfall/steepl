class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :member_id
      t.string :name
      t.string :dialing_code
      t.string :number
      t.string :mobile

      t.timestamps
    end
  end
end
