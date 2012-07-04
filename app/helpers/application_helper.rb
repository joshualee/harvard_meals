module ApplicationHelper
  def start_end_week_string(day)
    "Week of #{day.at_beginning_of_week.strftime("%-m/%-d")} - #{day.at_end_of_week.strftime("%-m/%-d")}"
  end
  
  def day_to_string(day)
    "#{day.strftime("%A")} (#{day.strftime("%-m/%-d")})"
  end
end
