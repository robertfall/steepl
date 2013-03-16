class CreateFamilyRoles < ActiveRecord::Migration
  def change
    create_table :family_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
