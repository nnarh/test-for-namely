Rails.application.routes.draw do
  root 'pages#index'

  get '/employees' => 'employee_profiles#index', :as => :employees
  get '/auth/namely/callback', to: 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  delete '/logout', to: 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure'
end
