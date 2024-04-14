# frozen_string_literal: true

json.extract! timesheet_entry, :id, :employee_id, :started_at, :ended_at, :hours_worked, :comments,
              :entry_approval_status, :created_at, :updated_at
json.url timesheet_entry_url(timesheet_entry, format: :json)
