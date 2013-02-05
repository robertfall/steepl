class SongSetsSong < ActiveRecord::Base
  attr_accessible :song_set_id, :song_id, :lead_by
  belongs_to :song
  belongs_to :song_set
  scope :set_order, order('position_number')
end
