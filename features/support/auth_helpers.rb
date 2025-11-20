module AuthHelpers
  def log_in_as(user)
    # Cucumber runs outside controller context by default,
    # so we use rack-test to set the session manually.
    page.set_rack_session(user_id: user.id)
  end
end

World(AuthHelpers)
