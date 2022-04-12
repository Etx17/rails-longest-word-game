Rails.application.routes.draw do
  get 'logins/create'
  get '/new', to: 'games#new'
  post '/score', to: 'games#score'
end
