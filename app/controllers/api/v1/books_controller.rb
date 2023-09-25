class Api::V1::BooksController < ApplicationController
    def index
        @_search ||= BookSerializer.new(search_params)
        render json: @_search.serialize 
    end

    private

    def search_params
        params.permit(:location, :quantity)
    end
end