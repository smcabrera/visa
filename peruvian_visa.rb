require 'chronic_duration'
require 'chronic'
require 'active_support/all'

class PeruvianVisa
  attr_accessor :entry_date, :days_granted

  def initialize(entry_date, days_granted = 90)
    self.entry_date = self.parse_date(entry_date)
    self.days_granted = days_granted
  end

  def days_since_entry
    (Date.today - entry_date).to_i
  end

  def days_left
    days_granted - days_since_entry
  end

  def display_time_since_entry
    ChronicDuration.output(seconds_since_entry)
  end

  def parse_date(date)
    case date
    when Date
      date
    when Time
      date.to_date
    when String
      Chronic.parse(date).to_date
    else
      # TODO: Replace this string with an exception once you figure out the best way to od that.
      "You've passed me date in a format that I don't know how to deal with!"
    end
  end

  private

  def seconds_since_entry
    days_since_entry * 60 * 60 * 24
  end

end
