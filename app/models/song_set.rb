class SongSet < ActiveRecord::Base
  attr_accessible :name, :play_on, :finalized
  has_and_belongs_to_many :songs

  validates_presence_of :name, :play_on

  default_scope order('play_on DESC')
  scope :historic, where(['play_on < ?', Time.zone.today])
  scope :upcoming, where(['play_on > ?', Time.zone.today])
  scope :finalized, where(finalized: true)


  def self.latest
    SongSet.upcoming.finalized.first
  end
end
