require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
    before do
      @john = User.create(first_name: "John", last_name: "Adams", email: "john@example.com", password: "password")
    end
    
    context "owner can only edit his or her own articles" do
      it "renders edit template" do
        login_user @john
        article = Article.create(title: "First article", body: "Hello hello", user: @john)
        
        get :edit, id: article
        expect(response).to render_template :edit
      end
    end
    
    
    context "non-owner cannot edit others articles" do
      it "redirects to root path" do
        fred = User.create(first_name: "Fred", last_name: "Adams", email: "fred@example.com", password: "password")
        login_user fred
        
        article = Article.create(title: "First article", body: "Hello hello", user: @john)
        
        get :edit, id: article
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own articles."
        expect(flash[:danger]).to eq message
      end
    end
    
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
