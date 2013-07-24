# == Schema Information
#
# Table name: message_recipients
#
#  id               :integer          not null, primary key
#  messageable_id   :integer
#  messageable_type :string(255)
#  message_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class MessageRecipient < ActiveRecord::Base
  include AdapterHelper
  attr_accessible :messageable_id, :messageable_type, :message_id, :message

  belongs_to :messageable, polymorphic: true
  belongs_to :message

  validates_presence_of :messageable_id, :message_id

  def attachable_type
    messageable_type
  end

  def attachable
    messageable
  end
end
