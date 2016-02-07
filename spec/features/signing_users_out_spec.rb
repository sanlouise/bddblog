require "rails_helper"

RSpec.feature "Signing out" do
  
  before do
    @john = User.create!(first_name: "John", last_name: "Adams", email: "john@example.com", password: "password")
    visit "/"
    
    click_link "Login"
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"
  end
  
  scenario "Signing Out" do
    visit "/"
    click_link "Logout"
    expect(page).to have_content("Signed out successfully.")
  end
end