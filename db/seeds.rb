Team.destroy_all
User.destroy_all

# Create teams
team_day_job = FactoryBot.create(:team_day_job) # Takes @acme.com employees
team_night_job = FactoryBot.create(:team_night_job) # Will be empty team
team_weekend_job = FactoryBot.create(:team_weekend_job) # Can employ any user

# Create users
user_alice = FactoryBot.create(:user_alice)
user_bob = FactoryBot.create(:user_bob)
user_charlie = FactoryBot.create(:user_charlie) # Wants to listen into @acme.com

# Set team memberships
user_alice.add_role(:team_manager, team_day_job)
user_bob.add_role(:team_member, team_day_job)
user_bob.add_role(:team_owner, team_night_job)
user_bob.add_role(:team_manager, team_weekend_job)
user_charlie.add_role(:team_member, team_weekend_job)

user_alice.reload
user_bob.reload
user_charlie.reload