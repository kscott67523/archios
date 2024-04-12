Rails.application.routes.draw do
  resources :statuses
  resources :requests
  devise_for :employees, controllers: { registrations: "registrations" }

  authenticated :employee do
    root to: "employees#show", as: :authenticated_root
    resources :statuses
  end

  root "home#index"

  resources :messages
  resources :companies
  resources :timesheet_entries, except: [:index]
  resources :employees
end
