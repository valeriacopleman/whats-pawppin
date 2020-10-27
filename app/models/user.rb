class User < ActiveRecord::Base
    has_many :parks
    has_many :dogs
end