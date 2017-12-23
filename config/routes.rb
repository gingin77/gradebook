Rails.application.routes.draw do
  resources :students
  resources :courses, only: [:show, :index]
  resources :grades, except: [:index]
end
