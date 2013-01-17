class AddSongToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :song_id, :int
  end
end
