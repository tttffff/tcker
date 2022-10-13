FactoryBot.define do
  factory :user do
    email { "jonny@gmail.com" }
    password { "password" }
  end

  factory :user_alice, class: :user do
    email { "alice@acme.com" }
    password { "password" }
  end

  factory :user_bob, class: :user do
    email { "bob@acme.com" }
    password { "password" }
  end

  factory :user_charlie, class: :user do
    email { "ch4rl13@h4ck3r.com" }
    password { "password" }
  end
end
