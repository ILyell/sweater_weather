class UserSerializer

    def initialize(user, token)
        @user = user
        @token = token
    end

    def serialize
        {
            data: {
                type: "users",
                id: @user.id,
                attributes: {
                    email: @user.email,
                    api_key: @token
                }
            }
        }
    end
end