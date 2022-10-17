def create_with_role(klass, role)
    instance = FactoryBot.create(klass.to_s.downcase)
    user.add_role role, instance
    instance
end

def create_with_reader(klass)
    create_with_role(klass, (klass.can_read - klass.can_manage).sample)
end

def create_with_manager(klass)
    create_with_role(klass, klass.can_manage.sample)
end

def create_with_other(klass)
    create_with_role(klass, :random_role)
end