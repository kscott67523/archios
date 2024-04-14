# frozen_string_literal: true

class UpdateExistingEmployeesStatus < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        Employee.where(current_status: nil).update_all(current_status: '...')
      end
    end
  end
end
