require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do

    before do
      @jen = User.create(email: 'jen@email.com', password: 'password')
    end

    context "owner is allowed to edit her articles" do
      it "renders the edit template" do
        login_user @jen
        article = Article.create(title: "First Article", body: "This is a test", user: @jen)

        get :edit, id: article
        expect(response).to render_template :edit
      end
    end

    context "non-owner is not allowed to edit other user's articles" do
      it "redirects to the root path" do
        john = User.create(email: 'john@email.com', password: 'password')
        login_user john

        article = Article.create(title: "This is a test", body: "This is the body of the article.", user: @jen)

        get :edit, id: article
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own article."
        expect(flash[:danger]).to eq message
      end
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
