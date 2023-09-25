class Api::V1::BooksController < ApplicationController
    def index
        render josn: BookSerializer.new(search_params).serialize 
    end

    private

    def search_params
        params.permit(:location, :quantity)
    end
end