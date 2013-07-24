# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  subject      :string(255)
#  body         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  message_type :string(255)
#  sent_at      :datetime
#

class Message < ActiveRecord::Base
  SMS = 'SMS'
  EMAIL = 'EMAIL'
  attr_accessible :body, :subject, :message_type
  has_many :attachments, dependent: :destroy, class_name: 'MessageAttachment'
  has_many :recipients, dependent: :destroy, class_name: 'MessageRecipient'

  def empty?
    !subject and !body and attachments.empty? and recepeients.empty?
  end

  def display_name
    subject.present? ? subject : "No Title"
  end
end
