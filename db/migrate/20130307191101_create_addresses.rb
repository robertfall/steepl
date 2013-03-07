class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :member_id
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
