Given("I am logged in") do
  @user = FactoryBot.create(:user)
  log_in_as(@user)
end

Given("I am logged in as a different user") do
  @user = FactoryBot.create(:user)
  log_in_as(@user)
end

# When("I visit my profile") do
#   visit user_path(@user)
# end

# Then("I should see {string}") do |text|
#   expect(page).to have_content(text)
# end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value, visible: :all
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end
