require 'rails_helper'

RSpec.feature "UserSeesOrganizationsLists", type: :feature do
  scenario "logged in user sees his/her organizations list" do
    VCR.use_cassette("github_service#organizations") do
      login

      expect(current_path).to eq dashboard_path

      click_on("Organizations")

      expect(current_path).to eq organizations_path
      expect(page).to have_content("TuringTestOrganization")
    end
  end
end
