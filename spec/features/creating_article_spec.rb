require 'rails_helper'

RSpec.feature "Creating Articles" do
  
  before do
     @john = User.create!(first_name: "John", last_name: "Adams", email: "john@example.com", password: "password")
     login_as(@john)
  end
    
    
  scenario "User creates a new article" do
    visit "/" 
    
    click_link "New Article"
    
    fill_in "Title", with: "Creating first_article"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Create Article"
    
    expect(page).to have_content("Your article was created successfully!")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@john.first_name}")
    
  end
  
  scenario "User fails to create a new article" do
    visit "/" 
    
    click_link "New Article"
    
    fill_in "Title", with: " "
    fill_in "Body", with: " "
    click_button "Create Article"
    
    expect(page).to have_content("Your article was not created!")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
    
  end
  
  
end

