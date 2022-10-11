require 'rails_helper'

RSpec.describe "Teams", type: :system do
  before { @team = FactoryBot.create(:team_day_job) }

  scenario "user creates a team" do
    visit teams_path
    expect(page).to have_css("h1", text: "Teams")

    click_on "New team"
    expect(page).to have_css("h1", text: "New team")

    fill_in "Name", with: "Team 1"
    click_on "Create Team"

    expect(page).to have_css("h1", text: "Teams")
    expect(page).to have_content("Team 1")
  end

  scenario "looking at a team" do
    visit teams_path
    click_link @team.name

    expect(page).to have_css("h1", text: @team.name)
  end
  
  scenario "updating a team" do
    visit teams_path
    expect(page).to have_css("h1", text: "Teams")

    click_on "Edit", match: :first
    expect(page).to have_css("h1", text: "Edit team")

    fill_in "Name", with: "Updated team"
    click_on "Update Team"

    expect(page).to have_css("h1", text: "Teams")
    expect(page).to have_content("Updated team")
  end
  
  scenario "Destroying a quote" do
    visit teams_path
    expect(page).to have_content(@team.name)

    click_on "Delete", match: :first
    expect(page).to_not have_content(@team.name)
  end
end
