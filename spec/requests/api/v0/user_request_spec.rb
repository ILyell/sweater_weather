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

    it 'Returns the api key when sent a current user email and password' do

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

        expect(data[:data][:attributes]).to have_key(:api_key)

        key = data[:data][:attributes][:api_key]

        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "email": "whatever@example.com",
            "password": "password",
        }
        body = JSON.generate(params)

        post "/api/v0/sessions", headers: headers, params: body

        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:data]).to have_key(:type)
        expect(data[:data]).to have_key(:id)
        expect(data[:data]).to have_key(:attributes)
        expect(data[:data][:attributes]).to have_key(:email)
        expect(data[:data][:attributes]).to have_key(:api_key)

        expect(data[:data][:attributes][:api_key]).to eq(key)

    end

    it 'returns 400 if email or password not present/correct' do

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

        expect(data[:data][:attributes]).to have_key(:api_key)

        key = data[:data][:attributes][:api_key]

        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "email": "whatever@example.com",
            "password": "passwordsssss",
        }
        body = JSON.generate(params)

        post "/api/v0/sessions", headers: headers, params: body

        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to eq("Incorrect Email / Or Password")
    end
end