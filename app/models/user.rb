class User < ApplicationRecord
  rolify
  # All roles should reference an instance. This is incase of bugs.
  rolify strict: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username

  before_validation :make_username, on: :create
  after_create :create_team

  rolify after_add: :invalidate_cache, after_remove: :invalidate_cache

  def invalidate_cache(role)
    Rails.cache.delete_matched("role_cache#{self.id}#{role.resource_type}")
  end

  def allowed_resource_ids(resource, action)
    valid_roles = resource.send(action)
    # TODO: Consider the expiry time.
    Rails.cache.fetch("role_cache#{self.id}#{resource}#{valid_roles}", expires_in: 5.days) do
      resource.with_role(valid_roles, self).pluck(:id)
    end
  end

  private

  # Instead of getting the user to add a username at sign up, we'll just make one for them
  # They can always change it later. Saves putting them off at sign up.
  def make_username
    self.username = email.split("@").first + rand(10000..99999).to_s
  end

  # Add the user to their own (default) team
  def create_team
    team = Team.create(name: "My Team")
    add_role :team_owner, team
  end
end
