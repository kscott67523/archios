class RemoveColumnNameFromEmployee < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :status, :string
  end
end
