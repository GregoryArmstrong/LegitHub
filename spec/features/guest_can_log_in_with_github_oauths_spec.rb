require 'rails_helper'

RSpec.feature "GuestCanLogInWithGithubOauths" do
  scenario "successfully redirects to dashboard path with github oauth login" do
    skip
    visit root_path

    expect(page).to have_content("Welcome to LegitHub")
    expect(page).to have_content("Login with Github")

    click_link("Login with Github")

    expect(current_path).to eq dashboard_path
  end
end
