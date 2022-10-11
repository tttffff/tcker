FactoryBot.define do
  factory :team do
    name { "My Team" }
  end

  factory :team_day_job, class: :team do
    name { "Corporate Peeps" }
  end

  factory :team_night_job, class: :team do
    name { "Night Owls" }
  end

  factory :team_weekend_job, class: :team do
    name { "Weekend Warriors" }
  end
end
