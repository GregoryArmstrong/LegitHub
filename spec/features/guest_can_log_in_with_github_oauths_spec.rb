require 'rails_helper'

RSpec.feature "GuestCanLogInWithGithubOauths" do
  scenario "successfully redirects to dashboard path with github oauth login" do
    VCR.use_cassette("github_service#login") do

    visit root_path
    expect(page).to have_content("Welcome to LegitHub")

    click_on("Login with Github")

    expect(current_path).to eq dashboard_path

    end
  end
end
