require 'rails_helper'

RSpec.feature "UserSeesFollowerAndFollowingInformationAndCommits", type: :feature do
  scenario "logged in user sees his/her followers/following info" do
    VCR.use_cassette("github_service#following") do
      login

      expect(current_path).to eq dashboard_path
      expect(page).to have_content("Followers: 3")
      expect(page).to have_content("Following: 16")
    end
  end

  scenario "logged in user sees his/her starred repositories" do
    VCR.use_cassette("github_service#starred") do
      login

      expect(current_path).to eq dashboard_path
      expect(page).to have_content("Starred Repositories: 0")
    end
  end

  scenario "logged in user sees his/her commit-related info" do
    VCR.use_cassette("presenter#year_commits") do
      login

      expect(current_path).to eq dashboard_path
      expect(page).to have_content("Yearly Commits: 49")
      expect(page).to have_content("Longest Streak: 12 days")
      expect(page).to have_content("Current Streak: 3 days")
    end
  end
end
