class Dog < ActiveRecord::Base

    belongs_to :owner

    validates :name, :age, :breed, :owner_id, :owner, presence: true
    
end