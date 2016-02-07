require "rails_helper"

RSpec.feature "Editing an Article" do
  before do
    
    john = User.create!(first_name: "John", last_name: "Adams", email: "john@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "First Article", body: "Body of Article", user: john)
    
  end
  
  scenario "User Updates Article" do
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: "Updated article title"
    fill_in "Body", with: "Updated body of article"
    click_button "Update"
    
    expect(page).to have_content("Article was updated successfully.")
    expect(page.current_path).to eq(article_path(@article))
  end
  
  
  
  scenario "User Fails to Update Article" do
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: " "
    fill_in "Body", with: ""
    click_button "Update"
    
    expect(page).to have_content("Article could not be updated.")
    expect(page.current_path).to eq(article_path(@article))
  end
end