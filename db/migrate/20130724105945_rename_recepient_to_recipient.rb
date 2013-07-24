class RenameRecepientToRecipient < ActiveRecord::Migration
  def change
    rename_table :message_recepients, :message_recipients
  end

end
