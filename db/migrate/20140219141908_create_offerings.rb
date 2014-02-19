class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.references :member
      t.integer :amount_cents
      t.date :given_on
      t.string :method
      t.integer :created_by_id

      t.timestamps
    end
    add_index :offerings, :member_id
  end
end
