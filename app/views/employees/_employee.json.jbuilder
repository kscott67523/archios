# frozen_string_literal: true

json.extract! employee, :id, :employee_id, :email, :password, :first_name, :last_name, :role, :company_id, :manager_id,
              :phone_number, :has_sms, :profile_picture, :time_zone, :created_at, :updated_at
json.url employee_url(employee, format: :json)
