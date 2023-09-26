class User < ApplicationRecord
    validates_presence_of :email
    validates_presence_of :password

    has_secure_password
end