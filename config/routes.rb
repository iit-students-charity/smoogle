Rails.application.routes.draw do
  resource :search, only: :show
  get '/result', to: 'searches#result'
  post '/search', to: 'searches#search'
end
