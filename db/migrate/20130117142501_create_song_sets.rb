class CreateSongSets < ActiveRecord::Migration
  def change
    create_table :song_sets do |t|
      t.string :name

      t.timestamps
    end
  end
end
