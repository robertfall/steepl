class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :key
      t.string :description

      t.timestamps
    end

    add_index :permissions, :key, :unique => true
  end
end
