class AddFieldsToMember < ActiveRecord::Migration
  def change
    add_column :members, :relationship_status, :string
    add_column :members, :employment_status, :string
    add_column :members, :cell_group, :string
    add_column :members, :preferred_service, :string
    add_column :members, :accept_communication, :boolean
  end
end
