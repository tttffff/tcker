class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Returns an array of roles that can read the resource. Implement in subclasses.
  def self.can_read
    raise NotImplementedError.new("Implement #{self.class}.roles_can_read")
  end

  # Returns an array of roles that can manage the resource. Implement in subclasses.
  def self.can_manage
    raise NotImplementedError.new("Implement #{self.class}.roles_can_manage")
  end
end
