require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    before do
      @jen = User.create(email: 'jen@email.com', password: 'password')
    end
    
    context "signed in user" do
      it "can create a comment" do
        login_user @jen
        article = Article.create(title: "This is the title", 
          body: "This is the body of the article", 
          user: @jen)
        post :create, comment: {body: "Great post!"},
        article_id: article.id
        expect(flash[:success]).to eq("Comment has been created")
      end
    end
    context "non-signed in user" do
      it "is redirected to the sign in page" do
        login_user nil
        article = Article.create(title: "This is the title", 
          body: "This is the body of the article", 
          user: @jen)
        post :create, comment: {body: "Great post!"},
        article_id: article.id
        expect(response).to redirect_to new_user_session_path
      end
    end
    
  end
end
