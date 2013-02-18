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
  attr_accessible :name, :play_on, :published, :message
  has_many :song_sets_songs
  has_many :songs, through: :song_sets_songs

  validates_presence_of :name, :play_on

  scope :historic,  -> { where(['play_on < ?', Time.zone.today]) }
  scope :upcoming, -> { where(['play_on >= ?', Time.zone.today.beginning_of_day]) }
  scope :published, where(published: true)
  scope :unprocessed, where(processed: false).order('play_on')

  after_update :send_email

  def message_html
    parser = BlueCloth.new(message).to_html
  end

  def songs_in_set_order
    song_sets_songs.joins(:song).includes(:song => [:latest_mp3, :latest_sheet_music]).set_order
  end

  def self.latest
    SongSet.includes(:songs => [ :latest_mp3, :latest_sheet_music, :attachments]).upcoming.published.first
  end

  def self.process_sets!
    historic.unprocessed.each do |set|
      set.songs.each do |song|
        song.update_column(:last_played_on, set.play_on)
      end
      set.update_column(:processed, true)
    end
  end

  def send_email
    UserMailer.set_list(self).deliver if (self.published_changed? && self.published == true)
  end
end
