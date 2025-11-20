When("I visit the {string} page") do |page_name|
  case page_name
  when "Home" then visit root_path
  when "Clubs" then visit clubs_path
  when "Events" then visit events_path
  else
    raise "No path mapping defined for: #{page_name}"
  end
end
