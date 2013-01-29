class AddPositionToSongSetSongs < ActiveRecord::Migration
  def change
    add_column :song_sets_songs, :position_number, :integer
  end
end
