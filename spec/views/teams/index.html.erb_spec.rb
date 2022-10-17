require "rails_helper"

RSpec.describe "teams/index", type: :view do
  before(:each) do
    user = FactoryBot.create(:user)
    teams = FactoryBot.create_list(:team, 2, name: "Team 1")
    teams.each { |team| user.add_role :team_member, team }
    assign(:teams, teams)
    sign_in user
  end

  it "renders a list of teams" do
    render
    assert_select "section>a", text: "Team 1", count: 2
  end
end
