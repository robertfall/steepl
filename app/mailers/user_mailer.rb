class UserMailer < ActionMailer::Base
  include ApplicationHelper

  default from: '"Worship Bot" <worshipbot@tvmethodist.co.za>'

  def set_list(set)
    @set = set
    mail(:to => "worshipteam@tvmethodist.co.za",
         :subject => "New Worship Set for #{play_on_in_words(@set.play_on)}")
  end
end
