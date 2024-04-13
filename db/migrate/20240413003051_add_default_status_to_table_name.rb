class AddDefaultStatusToTableName < ActiveRecord::Migration[7.0]
  def change
    change_column_default :statuses, :text, "What are you up to?"
  end
end
