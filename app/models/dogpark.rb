class Dogpark < ActiveRecord::Base
    belongs_to :user

    validates :name, :location, :description, :user_id, :user, presence: true
end