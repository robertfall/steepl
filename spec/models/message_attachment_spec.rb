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

require 'spec_helper'

describe MessageAttachment do
  pending "add some examples to (or delete) #{__FILE__}"
end
