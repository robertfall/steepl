# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  body       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :body, :subject, :type
  has_many :attachments, dependent: :destroy, class_name: 'MessageAttachment'

  def empty?
    !subject and !body and attachments.empty?
  end
end
