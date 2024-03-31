class ChangeManagerIdToNullableInEmployees < ActiveRecord::Migration[7.0]
  def change
    change_column_null :employees, :manager_id, true
  end
end
