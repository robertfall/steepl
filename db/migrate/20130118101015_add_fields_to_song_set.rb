class AddFieldsToSongSet < ActiveRecord::Migration
  def change
    add_column :song_sets, :play_on, :date
    add_column :song_sets, :finalized, :boolean
  end
end
