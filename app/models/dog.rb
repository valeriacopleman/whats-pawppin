class Dog < ActiveRecord::Base
    belongs_to :user

    validates :name, :age, :breed, :user_id, :user, presence: true
end