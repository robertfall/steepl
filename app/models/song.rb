class Song < ActiveRecord::Base
  attr_accessible :name
  has_many :attachments
  has_and_belongs_to_many :song_sets
  validates_presence_of :name

  default_scope order(:name)

  def has_sheetmusic?
    attachments.any?(&:pdf?)
  end

  def has_mp3?
    attachments.any?(&:mp3?)
  end

  def latest_mp3
    attachments.order('created_at DESC').select(&:mp3?).first
  end

  def latest_sheetmusic
    attachments.order('created_at DESC').select(&:pdf?).first
  end
end
