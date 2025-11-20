Given("a club exists named {string}") do |name|
  @club = FactoryBot.create(:club, name:)
end

Given("I have joined the club {string}") do |name|
  @club = FactoryBot.create(:club, name:)
  @user ||= FactoryBot.create(:user)
  log_in_as(@user)
  Membership.create(user: @user, club: @club)
end

Given("I am the owner of a club named {string}") do |name|
  @user = FactoryBot.create(:user)
  log_in_as(@user)
  @club = FactoryBot.create(:club, user: @user, name:)
end

When("I visit the clubs page") do
  visit clubs_path
end

When("I visit the Edit Club page for {string}") do |club_name|
  club = Club.find_by(name: club_name)
  visit edit_club_path(club)
end

Then("I should see a list of clubs") do
  Club.all.each do |club|
    expect(page).to have_content(club.name)
  end
end

Given("a club exists named {string} owned by another user") do |name|
  other_user = FactoryBot.create(:user)
  @club = FactoryBot.create(:club, name:, user: other_user)
end

Given("a club {string} exists and is owned by someone else") do |name|
  other_user = FactoryBot.create(:user)
  @club = FactoryBot.create(:club, name:, user: other_user)
end

Then("I should not see {string}") do |text|
  expect(page).not_to have_content(text)
end

When("I check {string}") do |field|
  check field
end

When("I visit the club page for {string}") do |club_name|
  club = Club.find_by(name: club_name)
  if club
    visit club_path(club)
  else
    raise "Club not found: #{club_name}"
  end
end
