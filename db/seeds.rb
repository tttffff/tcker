# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Team.destroy_all
FactoryBot.create(:team_day_job)
FactoryBot.create(:team_night_job)
FactoryBot.create(:team_weekend_job)