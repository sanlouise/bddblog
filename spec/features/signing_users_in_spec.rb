require "rails_helper"

RSpec.feature "Users log in" do
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
  end
  
  scenario "Valid Credentials" do
    visit "/"
    
    click_link "Log In"
    

    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password

    click_button "Log in"
    
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@john.email}")
  end
end