Rails.application.routes.draw do
  get 'users/new'

  get 'users/create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :students
  resources :courses, only: [:show, :index]
  resources :grades, except: [:index]
end
