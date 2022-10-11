require 'rails_helper'

RSpec.describe "teams/index", type: :view do
  before(:each) do
    assign(:teams, FactoryBot.create_list(:team, 2, name: "Team 1"))
  end

  it "renders a list of teams" do
    render
    assert_select "p>a", text: "Team 1", count: 2
  end
end
