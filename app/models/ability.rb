# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user # guest user (not logged in, no permissions)
    can :read, Team, id: user.allowed_resource_ids(Team, :can_read)
    can :manage, Team, id: user.allowed_resource_ids(Team, :can_manage)
    can :create, Team
  end
end
