class AddCacheFieldsToSong < ActiveRecord::Migration
  def change
    add_column :songs, :latest_mp3_id, :integer
    add_column :songs, :latest_sheet_music_id, :integer
    add_column :songs, :last_played_on, :date
  end
end
