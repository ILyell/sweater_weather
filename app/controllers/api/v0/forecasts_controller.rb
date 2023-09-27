class Api::V0::ForecastsController < ApplicationController

    def show
        render json: ForecastFacade.new(search_params).serialize
    end

    private

    def search_params
        params.permit(:location)
    end
end