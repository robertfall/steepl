# == Schema Information
#
# Table name: message_attachments
#
#  id              :integer          not null, primary key
#  attachable_id   :integer
#  attachable_type :string(255)
#  message_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class MessageAttachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :message_id, :attachable
  belongs_to :attachable, polymorphic: true
  belongs_to :message

  def adapter
    klass = Kernel.const_get("#{attachable_type}Adapter")
    klass.new(attachable)
  end
end
