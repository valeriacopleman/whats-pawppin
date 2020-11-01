class Owner < ActiveRecord::Base

    has_many :parks
    has_many :dogs

    validates_presence_of :name, :username, :password
    validates :username, uniqueness: true

    has_secure_password
    
end