require 'rails_helper'

RSpec.feature "Showing an Article" do

  before do
    @jen = User.create(email: "jen@email.com", password: "password")
    @john = User.create(email: "john@email.com", password: "password")
    @article = Article.create(title: "The first article", body: "This is the body of the first article", user: @john)
  end

  scenario "A non-signed in user does not see Edit or Delete Links" do
    visit '/'

    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A non-owner signed in cannot see both links" do
    login_as(@jen)
    visit '/'

    click_link @article.title
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A signed-in owner can see both links" do
    login_as(@john)
    visit '/'

    click_link @article.title
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "Display individual article" do
    visit '/'

    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end