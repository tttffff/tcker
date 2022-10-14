class Team < ApplicationRecord
    resourcify
    
    validates :name, presence: true

    scope :ordered, -> { order(id: :desc) }

    def self.can_read
        %i[team_owner team_manager]
    end

    def self.can_manage
        %i[team_owner team_manager team_member]
    end
end