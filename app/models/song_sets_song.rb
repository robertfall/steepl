class SongSetsSong < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :song
  belongs_to :song_set
  scope :set_order, order('position_number')
end
