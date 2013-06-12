# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Permission do
  pending "add some examples to (or delete) #{__FILE__}"
end
