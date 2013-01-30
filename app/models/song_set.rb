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

  scope :historic, where(['play_on < ?', Time.zone.today])
  scope :upcoming, where(['play_on >= ?', Time.zone.today])
  scope :finalized, where(finalized: true)
  scope :unprocessed, where(processed: false).order('play_on')

  def self.latest
    SongSet.includes(:songs => [ :latest_mp3, :latest_sheet_music, :attachments]).upcoming.finalized.first
  end

  def self.process_sets!
    historic.unprocessed.each do |set|
      set.songs.each do |song|
        song.update_column(:last_played_on, set.play_on)
      end
      set.update_column(:processed, true)
    end
  end
end
