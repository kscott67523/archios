class AddDefaultStatusToEmployees < ActiveRecord::Migration[7.0]
  def change
    change_column_default :employees, :current_status, "..."
  end
end
