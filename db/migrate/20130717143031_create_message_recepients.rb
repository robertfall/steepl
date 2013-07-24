class CreateMessageRecipients < ActiveRecord::Migration
  def change
    create_table :message_recipients do |t|
      t.integer :messageable_id
      t.string :messageable_type
      t.integer :message_id

      t.timestamps
    end
  end
end
