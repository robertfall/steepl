class Attachment < ActiveRecord::Base
  attr_accessible :url
  belongs_to :song

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
end
