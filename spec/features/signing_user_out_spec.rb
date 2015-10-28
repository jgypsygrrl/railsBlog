require 'rails_helper'

RSpec.feature "Signing out signed-in users" do

  before do
    @jen = User.create!(email: 'jen@email.com', password: 'password')
    visit '/'

    click_link "Sign In"
    fill_in "Email", with: @jen.email
    fill_in "Password", with: @jen.password
    click_button "Log in"
  end

  scenario do
    visit '/'
    click_link "Sign out"
    expect(page).to have_content('Signed out successfully.')
  end

end