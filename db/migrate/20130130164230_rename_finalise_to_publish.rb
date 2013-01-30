class RenameFinaliseToPublish < ActiveRecord::Migration
  def change
    rename_column :song_sets, :finalized, :published
  end
end
