require "icalendar"

class IcsGenerator
  def self.event(event)
    cal = Icalendar::Calendar.new

    cal.event do |e|
      e.dtstart     = event.date.to_datetime
      e.dtend       = (event.date + 1.hour).to_datetime # or event.end_time if you have one
      e.summary     = event.name
      e.description = event.description.presence || ""
      e.location    = event.location if event.respond_to?(:location)
      e.uid         = "event-#{event.id}@clubhouse"
    end

    cal.publish
    cal.to_ical
  end
end

class IcsCombinedGenerator
  def self.events(events)
    cal = Icalendar::Calendar.new

    events.each do |event|
      cal.event do |e|
        e.dtstart     = event.date.to_datetime
        e.dtend       = (event.date + 1.hour).to_datetime # adjust if you have real end times
        e.summary     = event.name
        e.description = event.description.presence || ""
        e.location    = event.location if event.respond_to?(:location)
        e.uid         = "event-#{event.id}@clubhouse"
      end
    end

    cal.publish
    cal.to_ical
  end
end