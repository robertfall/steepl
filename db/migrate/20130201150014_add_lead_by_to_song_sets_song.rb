class AddLeadByToSongSetsSong < ActiveRecord::Migration
  def change
    add_column :song_sets_songs, :lead_by, :string
  end
end
