# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # Define new and create in the subpolicy
  def new?
    raise NotImplementedError.new("Implement #{self.class}.new?")
  end

  def create?
    raise NotImplementedError.new("Implement #{self.class}.create?")
  end

  # Everyone can index (items are filtered by policy_scope)
  def index?
    true
  end

  def show?
    matching_role?(:can_read)
  end

  def edit?
    matching_role?(:can_manage)
  end

  def update?
    matching_role?(:can_manage)
  end

  def destroy?
    matching_role?(:can_manage)
  end

  private

  # - Could have used the following:
  # roles = record.class.send(role_key)
  # roles.map { |role| user.has_role? role, record }.any?
  # - But that would do a DB query for each role.
  # - It would be nice if rolify included a user.has_any_role? method that can work on records
  # - AFAIK, rolify does not support this. However, the way below is still just one DB query.
  # - The with_role function can search for multiple roles (as done here), but works on the class.
  # - That explains the weirdness of getting the class but doing a where to only look at this record.
  def matching_role?(role_key)
    klass = record.class
    klass.where(id: record).with_role(klass.send(role_key), user).any?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.with_role(scope.can_read, user)
    end

    private

    attr_reader :user, :scope
  end
end
