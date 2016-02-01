require "rails_helper"

RSpec.feature "Deleting an Article" do
  before do
    @article = Article.create(title: "First Article", body: "Body of Article")
  end
  
  scenario "User Deletes Article" do
    visit "/"
    
    click_link @article.title
    click_link "Delete Article"
    
    expect(page).to have_content("Your article was deleted successfully.")
    expect(current_path).to eq(articles_path)
  end
end