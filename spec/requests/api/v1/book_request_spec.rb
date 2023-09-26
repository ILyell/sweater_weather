require 'rails_helper'

describe 'Book Request', type: :request do
    describe 'book search endpoint' do
        it 'returns a json when the correct params are passed', :vcr do

            get api_v1_book_search_path, params: { location: 'denver,co', quantity: 5 }

            expect(response).to be_successful
            books = JSON.parse(response.body, symbolize_names: true)

            expect(books).to have_key(:data)

            expect(books[:data]).to have_key(:id)
            expect(books[:data]).to have_key(:type)
            expect(books[:data]).to have_key(:attributes)

            expect(books[:data][:attributes]).to have_key(:destination)
            expect(books[:data][:attributes]).to have_key(:forecast)
            expect(books[:data][:attributes]).to have_key(:total_books_found)
            expect(books[:data][:attributes]).to have_key(:books)

            expect(books[:data][:attributes][:books]).to be_a(Array)
            expect(books[:data][:attributes][:books].count).to eq(5)

        end
    end
end