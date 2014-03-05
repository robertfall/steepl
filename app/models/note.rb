class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :member

  attr_accessible :message
end
