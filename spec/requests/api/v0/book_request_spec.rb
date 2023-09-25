require 'rails_helper'

describe Api::V0::BooksController, type: :request do
    describe 'book search endpoint' do
       xit 'returns a json when the correct params are passed' do

            get api_v0_book_path, params = { location: 'denver,co', quantity: 5 }


        end
    end
end