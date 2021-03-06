# == Schema Information
#
# Table name: song_sets_songs
#
#  id              :integer          not null, primary key
#  song_set_id     :integer
#  song_id         :integer
#  position_number :integer
#  lead_by         :string(255)
#

class SongSetsSong < ActiveRecord::Base
  attr_accessible :song_set_id, :song_id, :lead_by
  belongs_to :song
  belongs_to :song_set
  scope :set_order, -> { order('position_number') }
  after_create :determine_position_number

  def determine_position_number
    update_column(:position_number, song_set.song_sets_songs.count)
  end
end
