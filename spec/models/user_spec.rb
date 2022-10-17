require "rails_helper"
require "cancan/matchers"
require "support/create_with_role_helpers"

RSpec.describe User, type: :model do
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { FactoryBot.create(:user) }

    describe "teams" do
      context "user has a read role" do
        before { @team = create_with_reader(Team) }

        it { is_expected.to be_able_to(:read, @team) }
        it { is_expected.not_to be_able_to(:manage, @team) }
        it { is_expected.not_to be_able_to(:update, @team) }
        it { is_expected.not_to be_able_to(:destroy, @team) }
      end

      context "user has a manager role" do
        before { @team = create_with_manager(Team) }

        it { is_expected.to be_able_to(:manage, @team) }
      end

      context "user does not have a manager or a reader role" do
        before { @team = create_with_other(Team) }

        it { is_expected.not_to be_able_to(:read, @team) }
        it { is_expected.not_to be_able_to(:manage, @team) }
        it { is_expected.not_to be_able_to(:update, @team) }
        it { is_expected.not_to be_able_to(:destroy, @team) }
      end
    end
  end
end
