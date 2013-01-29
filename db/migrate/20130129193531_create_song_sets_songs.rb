class CreateSongSetsSongs < ActiveRecord::Migration
  def change
    create_table :song_sets_songs do |t|

      t.timestamps
    end
  end
end
