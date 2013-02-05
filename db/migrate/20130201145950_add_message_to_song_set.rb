class AddMessageToSongSet < ActiveRecord::Migration
  def change
    add_column :song_sets, :message, :text
  end
end
