# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tmail_subscriptions
  mount Griddler::Engine, at: '/requests'

  root "home#index"

  devise_for :employees, controllers: { registrations: "registrations" }
  
  resources :employees do
    resources :timesheet_entries, only: [:create]
  end

  authenticated :employee do
    root to: "employees#show", as: :authenticated_root
    resources :statuses
  end

  resources :statuses
  resources :requests
  resources :messages
  resources :companies
  resources :timesheet_entries, except: [:index]
  resources :employees
  get "*path", to: "home#index"
end
