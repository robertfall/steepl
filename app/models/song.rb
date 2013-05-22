# == Schema Information
#
# Table name: songs
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  audio                 :string(255)
#  sheet_music           :string(255)
#  latest_mp3_id         :integer
#  latest_sheet_music_id :integer
#  last_played_on        :date
#

class Song < ActiveRecord::Base
  attr_accessible :name, :latest_mp3_id, :latest_sheet_music_id, :last_played_on
  has_many :attachments
  has_many :song_sets_songs
  has_many :song_sets, through: :song_sets_songs
  belongs_to :latest_mp3, class_name: 'Attachment'
  belongs_to :latest_sheet_music, class_name: 'Attachment'
  has_many :attachments, class_name: 'MessageAttachment', as: :attachable

  validates_presence_of :name

  scope :alphabetic, order(:name)

  def slug
    name.tr(' ', '-').downcase
  end

  def self.update_attachments!
    Song.all.each do |song|
      all_attachments = song.attachments.order('created_at')

      latest_mp3 = all_attachments.select(&:mp3?).first
      latest_sheet_music = all_attachments.select(&:pdf?).first

      song.update_column(:latest_mp3_id, latest_mp3.id) if latest_mp3
      song.update_column(:latest_sheet_music_id, latest_sheet_music.id) if latest_sheet_music
    end
  end
end
