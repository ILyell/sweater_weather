class UserSerializer

    def self.serialize(user, token)
        {
            data: {
                type: "users",
                id: user.id,
                attributes: {
                    email: user.email,
                    api_key: token
                }
            }
        }
    end
end