Rails.application.routes.draw do
  devise_for :employees

  root "home#index"

  resources :messages
  resources :companies
  resources :timesheet_entries
  resources :employees
end
