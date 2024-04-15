# frozen_string_literal: true

Rails.application.routes.draw do
  get "emails/receive"
  post "/incoming_emails", to: "emails#receive"

  root "home#index"

  devise_for :employees, controllers: { registrations: "registrations" }

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
