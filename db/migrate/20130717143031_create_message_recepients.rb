class CreateMessageRecepients < ActiveRecord::Migration
  def change
    create_table :message_recepients do |t|
      t.integer :messageable_id
      t.string :messageable_type
      t.integer :message_id

      t.timestamps
    end
  end
end
