require 'rails_helper'

RSpec.feature "UserSeesCommitsLists", type: :feature do
  scenario "logged in user sees his/her commits index list" do
    VCR.use_cassette("github_service#recent_commits") do
      login

      expect(current_path).to eq dashboard_path

      click_on("Commits")

      expect(current_path).to eq commits_path
      expect(page).to have_content("Following commits now display on dashboard, limited to 5 max per user")
      expect(page).to have_content("Added test for repositories index page")
    end
  end

  scenario "logged in user sees the commits from users he/she is following" do
    VCR.use_cassette("github_service#following_commits") do
      login

      expect(current_path).to eq dashboard_path

      click_on("Commits")

      expect(current_path).to eq commits_path
      expect(page).to have_content("brantwellman")
      expect(page).to have_content("TheObtuseAutodidact")
      expect(page).to have_content("Tman22")
      expect(page).to have_content("ToniRib")
      expect(page).to have_content("PenneyGadget")
    end
  end
end
