Rails.application.routes.draw do
  devise_for :employees, controllers: { registrations: 'registrations' }

  authenticated :employee do
    root to: 'employees#show', as: :authenticated_root
  end

  root "home#index"

  resources :messages
  resources :companies
  resources :timesheet_entries, except: [ :index ]
  resources :employees
end
