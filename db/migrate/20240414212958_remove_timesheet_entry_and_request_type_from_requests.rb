class RemoveTimesheetEntryAndRequestTypeFromRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :timesheet_entry_id, :bigint
    remove_column :requests, :request_type, :string
  end
end
