require "rails_helper"

RSpec.feature "Adding comments to article" do
  before do
    @jen = User.create(email: "jen@email.com", password: "password")
    @john = User.create(email: "john@email.com", password: "password")

    @article = Article.create(title: "First Article", body: "This is the body of the article", user: @jen)
  end

  scenario "permits a signed in user to write a comment" do
    login_as(@john)

    visit "/"
    click_link @article.title
    fill_in "New Comment", with: "Cool article"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("Cool article")
    expect(current_path).to eq(article_path(@article.comments.last.id))
  end
end