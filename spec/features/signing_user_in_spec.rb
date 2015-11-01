require 'rails_helper'

RSpec.feature "Users sign-in" do

  before do
    @john = User.create!(email: 'john@email.com', password: 'password')
  end

  scenario "with valid credentials" do
    visit '/'

    click_link 'Sign In'
    fill_in 'Email', with: @john.email
    fill_in 'Password', with: @john.password
    click_button 'Log in'

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@john.email}")
    expect(page).not_to have_link("Sign In")
    expect(page).not_to have_link("Sign Up")
    
  end
end
