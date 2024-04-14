# frozen_string_literal: true

class RenameCurrentStatusToStatusInEmployees < ActiveRecord::Migration[7.0]
  def change
    rename_column :employees, :current_status, :status
  end
end
