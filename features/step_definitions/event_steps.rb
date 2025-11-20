Given("a club {string} has an event {string}") do |club_name, event_name|
  club = FactoryBot.create(:club, name: club_name)
  FactoryBot.create(:event, club:, name: event_name)
end

Given("an event {string} exists") do |name|
  @event = FactoryBot.create(:event, name:)
end

Given("I have RSVPed to {string}") do |name|
  @event = FactoryBot.create(:event, name:)
  @user ||= FactoryBot.create(:user)
  login_as(@user, scope: :user)
  @event.update(users_attending: [@user.id])
end

When("I visit the event page for {string}") do |event_name|
  event = Event.find_by(name: event_name)
  visit event_path(event)
end

When("I press {string}") do |button|
  click_button button
end
