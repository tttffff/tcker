require 'rails_helper'
require 'support/create_with_role_helpers'

RSpec.describe "/teams", type: :request do
  let(:valid_attributes) { { name: "MyString" } }
  let(:invalid_attributes) { { name: nil } }
  let(:user) { FactoryBot.create(:user) }
  
  before { sign_in user }

  describe "GET /index" do
    it "renders a successful response" do
      get teams_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    context "when user has a read role" do
      it "renders a successful response" do
        team = create_with_reader(Team)
        get team_url(team)
        expect(response).to be_successful
      end
    end

    context "when the user doesn't have a read role" do
      it "redirects to the home page" do
        team = create_with_other(Team)
        get team_url(team)
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_team_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    context "when user has a manage role" do
      it "renders a successful response" do
        team = create_with_manager(Team)
        get edit_team_url(team)
        expect(response).to be_successful
      end
    end

    context "when the user doesn't have a manage role" do
      it "redirects to the home page" do
        team = create_with_other(Team)
        get edit_team_url(team)
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Team" do
        expect {
          post teams_url, params: { team: valid_attributes }
        }.to change(Team, :count).by(1)
      end

      it "redirects to the created team" do
        post teams_url, params: { team: valid_attributes }
        expect(response).to redirect_to(teams_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Team" do
        expect {
          post teams_url, params: { team: invalid_attributes }
        }.to change(Team, :count).by(0)
      end

      it "renders a response with a 422 status to display the 'new' template" do
        post teams_url, params: { team: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "when the user has a manage role" do
      context "with valid parameters" do
        let(:new_attributes) { { name: "MyString123" } }

        it "updates the requested team" do
          team = create_with_manager(Team)
          patch team_url(team), params: { team: new_attributes }
          team.reload
          expect(team.name).to eq("MyString123")
        end

        it "redirects to the team" do
          team = create_with_manager(Team)
          patch team_url(team), params: { team: new_attributes }
          team.reload
          expect(response).to redirect_to(teams_url)
        end
      end

      context "with invalid parameters" do
        it "renders a response with a 422 status to display the 'edit' template" do
          team = create_with_manager(Team)
          patch team_url(team), params: { team: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when the user doesn't have a manage role" do
      it "redirects to the home page" do
        team = create_with_other(Team).tap { |t| t.update!(name: "MyString123") }
        patch team_url(team), params: { team: { name: "ANYTHING" } }
        team.reload
        expect(team.name).to eq("MyString123") # The team name should not have changed
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "DELETE /destroy" do
    context "when the user has a manage role" do
      it "destroys the requested team" do
        team = create_with_manager(Team)
        expect {
          delete team_url(team)
        }.to change(Team, :count).by(-1)
      end

      it "redirects to the teams list" do
        team = create_with_manager(Team)
        delete team_url(team)
        expect(response).to redirect_to(teams_url)
      end
    end

    context "when the user doesn't have a manage role" do
      it "redirects to the home page" do
        team = create_with_other(Team)
        expect {
          delete team_url(team)
        }.to change(Team, :count).by(0)
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
