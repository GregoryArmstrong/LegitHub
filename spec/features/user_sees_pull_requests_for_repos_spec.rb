require 'rails_helper'

RSpec.feature "UserSeesPullRequestsLists", type: :feature do
  scenario "logged in user sees his/her pull requests list" do
    VCR.use_cassette("github_service#pull_requests") do
      login

      expect(current_path).to eq dashboard_path

      click_on("Repositories")

      within("//li[@id='GregoryArmstrong/LegitHub']") do
        click_on("Pull Requests")
      end

      expect(current_path).to eq pull_requests_path
      expect(page).to have_content("LegitHub")
      expect(page).to have_content("GregoryArmstrong")
      expect(page).to have_content("GregoryArmstrong:semi_real_pull_request")
    end
  end
end
