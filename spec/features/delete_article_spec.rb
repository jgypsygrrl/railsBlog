require 'rails_helper'

RSpec.feature "Deleting an article feature" do
  
  before do
    @article = Article.create(title: "First article", body: "This is the first article")
  end
  
  scenario "A user can delete an article" do
    visit "/"
    
    click_link @article.title
    click_link "Delete Article"
    
    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)    
  end
end