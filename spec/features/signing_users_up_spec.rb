require "rails_helper"

RSpec.feature "Users signup" do
  scenario "Valid Credentials" do
    visit "/"
    
    click_link "Sign Up"
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Adams"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Sign Up"
    
    expect(page).to have_content("You have signed up successfully.")
  end
end