module ApplicationHelper
  def delete_warning(name=nil)
    return 'Are you sure?' unless name
    "Are you sure you want to delete #{name}"
  end
  def play_on_in_words(date)
    date.strftime("%A, %B the #{date.day.ordinalize}")
  end

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
