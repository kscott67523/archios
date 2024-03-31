Rails.application.routes.draw do
  devise_for :employees

  root "employees#index"
  
  resources :messages
  resources :companies
  resources :timesheet_entries
  resources :employees
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
