class RemoveHasTmailFromEmployees < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :has_tmail, :boolean
  end
end
