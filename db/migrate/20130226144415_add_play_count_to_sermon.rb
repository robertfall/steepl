class AddPlayCountToSermon < ActiveRecord::Migration
  def change
    add_column :sermons, :play_count, :integer, default: 0
  end
end
