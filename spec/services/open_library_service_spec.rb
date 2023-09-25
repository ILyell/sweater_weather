require 'rails_helper'

RSpec.describe 'Open Library Service' do
    describe 'instance methods' do
        it 'returns books from a search query', :vcr do
            service = OpenLibraryService.new

            books = service.book_search("new orleans, la", 5)
            
            expect(books).to have_key(:numFound)
            expect(books).to have_key(:docs)
            expect(books[:docs]).to be_a(Array)
            expect(books[:docs].count).to eq(5)
            expect(books[:docs][0]).to have_key(:title)
        end
    end
end