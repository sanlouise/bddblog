require "rails_helper"

RSpec.feature "Deleting an Article" do
  before do
    
    john = User.create!(first_name: "John", last_name: "Adams", email: "john@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "First Article", body: "Body of Article", user: john)
    
  end
  
  scenario "User Deletes Article" do
    visit "/"
    
    click_link @article.title
    click_link "Delete Article"
    
    expect(page).to have_content("Your article was deleted successfully.")
    expect(current_path).to eq(articles_path)
  end
end