module ApplicationHelper
  def last_played_in_words(date)
    return unless date
    if date == Time.zone.today
      "Today"
    elsif date < Time.zone.today
      "#{time_ago_in_words(date)} ago"
    else
      "#{time_ago_in_words(date)} from now"
    end
  end
end
