require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /home" do
    context "when not logged in" do
      it "renders a successful response" do
        get root_path
        expect(response).to be_successful
      end
    end

    context "when logged in" do
      before { sign_in FactoryBot.create(:user) }
      it "renders a successful response" do
        get root_path
        expect(response).to be_successful
      end
    end
  end
end
