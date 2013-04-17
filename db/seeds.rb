# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
User.create(username: 'rob@robertfall.com',
            email: 'rob@robertfall.com',
            password: 'testing',
            worship_leader: true)

#  id                              :integer          not null, primary key
#  username                        :string(255)      not null
#  email                           :string(255)
#  crypted_password                :string(255)
#  salt                            :string(255)
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  worship_leader                  :boolean
