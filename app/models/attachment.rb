# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  song_id    :integer
#

class Attachment < ActiveRecord::Base
  attr_accessible :url

  belongs_to :song

  after_create :update_song

  scope :alphabetical, -> { order(:filename) }

  def filetype
    File.extname(url)
  end

  def filename
    File.basename(url, filetype).tr('+', ' ')
  end

  def mp3?
    filetype == '.mp3'
  end

  def pdf?
    filetype == '.pdf'
  end

  def update_song
    song.update_column :latest_mp3_id, self.id if mp3?
    song.update_column :latest_sheet_music_id, self.id if pdf?
  end
end
