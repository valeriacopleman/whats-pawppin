class User < ActiveRecord::Base
    has_many :parks
    has_many :dogs

    has_secure_password
end