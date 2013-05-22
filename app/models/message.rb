class Message < ActiveRecord::Base
  attr_accessible :body, :subject
  has_many :attachments, dependent: :destroy, class_name: 'MessageAttachment'
end
