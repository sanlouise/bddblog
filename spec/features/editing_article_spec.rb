require "rails_helper"

RSpec.feature "Editing an Article" do
  before do
    
    @john = User.create!(first_name: "John", last_name: "Adams", email: "john@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "First Article", body: "Body of Article")
    
  end
  
  scenario "User Updates Article" do
    visit "/"
    
    click_link @article.title
    click_link "Edit Article"
    
    fill_in "Title", with: "Updated Article"
    fill_in "Body", with: "Updated Article"
    
    click_button "Update"
    
    expect(page).to have_content("Article was updated successfully.")
    expect(page.current_path).to eq(article_path(@article))
  end
  
  
  
  scenario "User Fails to Update Article" do
    visit "/"
    
    click_link @article.title
    click_link "Edit Article"
    
    fill_in "Title", with: " "
    fill_in "Body", with: " "
    
    click_button "Update"
    
    expect(page).to have_content("Oops, something went wrong. Article could not be updated.")
    expect(page.current_path).to eq(article_path(@article))
  end
end