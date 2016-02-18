require 'rails_helper'

RSpec.feature "UserSeesRepositoriesLists", type: :feature do
  scenario "logged in user sees his/her repositories list" do
    VCR.use_cassette("github_service#repositories") do
      login

      expect(current_path).to eq dashboard_path

      click_on("Repositories")

      expect(current_path).to eq repositories_path
      expect(page).to have_content("LegitHub")
      expect(page).to have_content("apocalypsify")
      expect(page).to have_content("MoneyTracker")
    end
  end
end
