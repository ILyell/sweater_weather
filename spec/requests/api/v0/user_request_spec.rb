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
        
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:data]).to have_key(:type)
        expect(data[:data]).to have_key(:id)
        expect(data[:data]).to have_key(:attributes)
        expect(data[:data][:attributes]).to have_key(:email)
        expect(data[:data][:attributes]).to have_key(:api_key)
    end

    it 'Returns an error if fields not filled' do

        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "email": "whatever@example.com",
            "password": "",
            "password_confirmation": "password"
        }

        body = JSON.generate(params)
    
        post '/api/v0/users', headers: headers, params: body


        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)

        expect(errors[:errors][0]).to eq("Password confirmation doesn't match Password")
        expect(errors[:errors][1]).to eq("Password can't be blank")
    end
end