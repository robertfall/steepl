class AddDefaultValueToProcessed < ActiveRecord::Migration
  def change
    change_column :song_sets, :processed, :boolean, :default => false
  end
end
