require 'rails_helper'

RSpec.describe Api::V0::UsersController, type: :request do
    it 'Recieves a post to create a new user, and returns an api_key' do

        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "email": "whatever@example.com",
            "password": "password",
            "password_confirmation": "password"
        }
        
        body = JSON.generate(params)
    
        post '/api/v0/users', headers: headers, params: body

        expect(response.status).to eq(201)
        
        data = response.body

        expect(data[:data]).to have_key(:type)
        expect(data[:data]).to have_key(:id)
        expect(data[:data]).to have_key(:attributes)
        expect(data[:data][:attributes]).to have_key(:email)
        expect(data[:data][:attributes]).to have_key(:api_key)
    end
end