Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/home', to: 'users#show'

  resources :students
  resources :courses, only: [:show, :index]
  resources :grades, except: [:index]
end
