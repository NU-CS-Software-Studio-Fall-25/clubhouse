Given("I am logged in") do
  @user = FactoryBot.create(:user)
  login_as(@user, scope: :user)
end

Given("I am logged in as a different user") do
  @user = FactoryBot.create(:user)
  login_as(@user, scope: :user)
end

When("I visit my profile") do
  visit user_path(@user)
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end
