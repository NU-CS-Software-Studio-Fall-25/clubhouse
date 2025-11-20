Given("a club {string} has an event {string}") do |club_name, event_name|
  club = FactoryBot.create(:club, name: club_name)
  FactoryBot.create(:event, club:, name: event_name)
end

Given("an event {string} exists") do |name|
  @event = FactoryBot.create(:event, name:)
end

Given("I have RSVPed to {string}") do |event_name|
  @user ||= FactoryBot.create(:user)
  log_in_as(@user)
  event = Event.find_by(name: event_name)
  visit event_path(event)
  click_button("RSVP")
end

When("I visit the event page for {string}") do |event_name|
  event = Event.find_by(name: event_name)
  visit event_path(event)
end

When("I press {string}") do |button|
  click_button(button, match: :first)
end

When("I visit the new event page for {string}") do |club_name|
  club = Club.find_by(name: club_name)
  visit new_club_event_path(club)
end

Given("there are events {string} and {string}") do |name1, name2|
  FactoryBot.create(:event, name: name1)
  FactoryBot.create(:event, name: name2)
end

When("I visit the events page") do
  visit events_path
end

Then("I should see multiple future events created") do
  # Example: assert at least 2 events were created
  expect(Event.count).to be > 1
end
