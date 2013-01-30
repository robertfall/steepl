class AddProcessedToSongSets < ActiveRecord::Migration
  def change
    add_column :song_sets, :processed, :bool, default: false
  end
end
