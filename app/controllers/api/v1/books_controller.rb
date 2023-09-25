class Api::V1::BooksController < ApplicationController
    def index
        search = BookSerializer.new(search_params)
        render json: search.serialize 
    end

    private

    def search_params
        params.permit(:location, :quantity)
    end
end