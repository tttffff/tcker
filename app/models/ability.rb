# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Team, id: Team.bro(user).pluck(:id)
    # can :read, Team, "id < 5"
    # can :read, Team, id: ids_for_resource(user, Team, Team.can_read_roles)
    # can :manage, Team, id: ids_for_resource(user, Team, Team.can_read_roles)
    # can :manage, User, id: ids_for_resource(user, User, [:bro])
  end

  def ids_for_resource(user, model, roles)
    user.roles.where(name: roles, resource_type: model.to_s).pluck(:resource_id)
  end
end

# INSERT INTO "roles" ("name", "resource_type", "resource_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?) 
# NSERT INTO "users_roles" ("user_id", "role_id") VALUES (?, ?)