class MessageAttachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :message_id, :attachable
  belongs_to :attachable, polymorphic: true
  belongs_to :message

  def adapter
    klass = Kernel.const_get("#{attachable_type}Adapter")
    klass.new(attachable)
  end
end
