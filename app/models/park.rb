class Park < ActiveRecord::Base

    belongs_to :owner

    validates :name, :location, :description, :owner_id, :owner, presence: true
    
end