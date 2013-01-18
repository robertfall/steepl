class SongSet < ActiveRecord::Base
  attr_accessible :name, :play_on, :finalized
  has_and_belongs_to_many :songs

  validates_presence_of :name, :play_on

  default_scope order('created_at DESC')
end
