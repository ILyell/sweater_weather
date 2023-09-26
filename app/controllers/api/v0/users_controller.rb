class Api::V0::UsersController < ApplicationController

    def create
        user = User.create(user_create_params)
        if user.valid?
            token = JWT.encode({user_id: user.id}, Rails.application.credentials.internal_key[:key], 'HS256')
            render json: UserSerializer.new(user, token).serialize, status: 201 
        else
            render json: {errors: user.errors.full_messages}, status: 400
        end
    end

    private
    
    def user_create_params
        params.permit(:email, :password, :password_confirmation)
    end

    def login_params
end