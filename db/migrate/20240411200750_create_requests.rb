class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :request_type
      t.text :request_body
      t.references :timesheet_entry, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
