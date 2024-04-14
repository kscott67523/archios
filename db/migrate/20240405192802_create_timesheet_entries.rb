# frozen_string_literal: true

class CreateTimesheetEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :timesheet_entries do |t|
      t.references :employee, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at
      t.decimal :hours_worked
      t.text :comments
      t.string :entry_approval_status
      t.references :pay_period, foreign_key: true

      t.timestamps
    end
  end
end
