class User < ApplicationRecord
    validates_presence_of :email
    validates_confirmation_of :password

    has_secure_password
end