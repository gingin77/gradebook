Rails.application.routes.draw do
  get    '/intro',   to: 'users#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/home', to: 'users#show'

  resources :students, only: [:show, :index]
  resources :teachers, only: :show

  resources :courses, only: [:show, :index] do
    resources :enrollments, except: [:index, :show]
  end
end
