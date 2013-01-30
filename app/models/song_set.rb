# == Schema Information
#
# Table name: song_sets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  play_on    :date
#  finalized  :boolean
#

class SongSet < ActiveRecord::Base
  attr_accessible :name, :play_on, :finalized
  has_many :song_sets_songs
  has_many :songs, through: :song_sets_songs

  validates_presence_of :name, :play_on

  default_scope order('play_on DESC')
  scope :historic, where(['play_on < ?', Time.zone.today])
  scope :upcoming, where(['play_on >= ?', Time.zone.today])
  scope :finalized, where(finalized: true)


  def self.latest
    SongSet.upcoming.finalized.first
  end
end
