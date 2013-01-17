class CreateSongSetSongs < ActiveRecord::Migration
  def change
    create_table :song_sets_songs do |t|
      t.integer :song_set_id
      t.integer :song_id
    end
  end
end
