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

require 'spec_helper'

describe Message do
  pending "add some examples to (or delete) #{__FILE__}"
end
