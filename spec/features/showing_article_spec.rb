require "rails_helper"

RSpec.feature "Showing an article" do
  
  before do
    @john = User.create(first_name: "John", last_name: "Adams", email: "john@example.com", password: "password")
    @fred = User.create(first_name: "Fred", last_name: "Adams", email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Body of first article", user: @john)
  end
  
  scenario "Non signed in user cannot edit or delete article" do
    visit "/"
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "Non-owner cannot edit or delete article" do
  login_as(@fred)
    visit "/"
    click_link @article.title
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "Owner can edit or delete article" do
  login_as(@john)
    visit "/"
    click_link @article.title
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
  
  scenario "Display individual article" do
    visit "/"
    
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
  
end