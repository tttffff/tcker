class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username

  before_validation :make_username, on: :create
  after_create :create_team

  private

  # Instead of getting the user to add a username at sign up, we'll just make one for them
  # They can always change it later
  def make_username
    self.username = email.split("@").first + rand(10000..99999).to_s
  end

  # Add the user to their own (default) team
  def create_team
    team = Team.create(name: "My Team")
    add_role :team_owner, team
  end
end
