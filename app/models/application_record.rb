class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.bro(user)
    this_table = self.arel_table
    role_table = Role.arel_table
    user_roles_table = Arel::Table.new(:users_roles) # Can't get from model as it is just a join table
    join_role = this_table.join(role_table).on(role_table[:resource_type].eq(self.to_s).and(role_table[:resource_id].eq(this_table[:id])))
    join_user = role_table.join(user_roles_table).on(role_table[:id].eq(user_roles_table[:role_id]))
    Team.select(:id).joins(join_role.join_sources).joins(join_user.join_sources).where(role_table[:name].in(self.can_read_roles).and(user_roles_table[:user_id].eq(user.id)))
  end

  # Returns an array of roles that can read the resource. Implement in subclasses.
  def self.can_read_roles
    raise NotImplementedError.new("Implement #{self.class}.roles_can_read")
  end

  # Returns an array of roles that can manage the resource. Implement in subclasses.
  def self.can_manage_roles
    raise NotImplementedError.new("Implement #{self.class}.roles_can_manage")
  end
end
