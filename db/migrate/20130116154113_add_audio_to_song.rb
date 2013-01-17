class AddAudioToSong < ActiveRecord::Migration
  def change
    add_column :songs, :audio, :string
    add_column :songs, :sheet_music, :string
  end
end
