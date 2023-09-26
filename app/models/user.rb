class User < ApplicationRecord
    validates :email, uniqueness: true, presence: true
    validates_confirmation_of :password, presence: true

    has_secure_password
end