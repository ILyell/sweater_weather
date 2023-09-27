class Api::V0::RoadTripController < ApplicationController

    def show
        token = JWT.decode(session_params[:api_key],  Rails.application.credentials.internal_key[:key])
        user = User.find(token[0]["user_id"])
        if user
            render json: RoadTripFacade.new(session_params).serialize
        end
    rescue JWT::DecodeError
        render json: {errors: "Unauthorized"}, status: 401
    end

    private

    def session_params
        params.require(:road_trip).permit(:origin, :destination, :api_key)
    end
end