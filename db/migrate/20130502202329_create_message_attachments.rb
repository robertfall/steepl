class CreateMessageAttachments < ActiveRecord::Migration
  def change
    create_table :message_attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.integer :message_id

      t.timestamps
    end
  end
end
