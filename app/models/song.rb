class Song < ActiveRecord::Base
  attr_accessible :name, :audio, :sheet_music
end
