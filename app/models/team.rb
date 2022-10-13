class Team < ApplicationRecord
    resourcify
    
    validates :name, presence: true

    ROLES_CAN_MANAGE = %i[team_owner team_manager].freeze
    ROLES_CAN_READ = (ROLES_CAN_MANAGE + %i[team_member]).freeze

    scope :ordered, -> { order(id: :desc) }

    def self.can_read
        ROLES_CAN_READ
    end

    def self.can_manage
        ROLES_CAN_MANAGE
    end
end
