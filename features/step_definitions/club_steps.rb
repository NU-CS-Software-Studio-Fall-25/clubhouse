Given("a club exists named {string}") do |name|
  @club = FactoryBot.create(:club, name:)
end

Given("I have joined the club {string}") do |name|
  @club = FactoryBot.create(:club, name:)
  @user ||= FactoryBot.create(:user)
  login_as(@user, scope: :user)
  @club.users << @user
end

Given("I am the owner of a club named {string}") do |name|
  @user = FactoryBot.create(:user)
  login_as(@user, scope: :user)
  @club = FactoryBot.create(:club, user: @user, name:)
end

When("I visit the clubs page") do
  visit clubs_path
end

When("I visit the {string} page") do |club_name|
  club = Club.find_by(name: club_name)
  visit club_path(club)
end
