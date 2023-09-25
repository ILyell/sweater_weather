Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      resource :forecast, only: :show
    end
    namespace :v1 do
      get 'book-search', to: 'books#index'
    end
  end
end
