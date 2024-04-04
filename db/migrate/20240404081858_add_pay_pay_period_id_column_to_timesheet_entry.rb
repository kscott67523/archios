class AddPayPayPeriodIdColumnToTimesheetEntry < ActiveRecord::Migration[7.0]
  def change
    add_reference :timesheet_entries, :pay_period, foreign_key: true
  end
end
