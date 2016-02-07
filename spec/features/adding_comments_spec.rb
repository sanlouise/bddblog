require 'rails_helper'

RSpec.feature "Adding Comments" do
  before do
    @john = User.create(first_name: "John", last_name: "Adams", email: "john@example.com", password: "password")
    @fred = User.create(first_name: "Fred", last_name: "Adams", email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Body of first article", user: @john)
  end

  scenario "Permits signed in user to leave comment" do
  login_as(@fred)
  
  visit "/"
  click_link @article.title
  fill_in "New Comment", with: "Great article"
  click_button "Add Comment"
  
  expect(page).to have_content("Comment has been created")
  expect(page).to have_content("Great article")
  expect(current_path).to eq(article_path(@article.comments.last.id))
  end
end
