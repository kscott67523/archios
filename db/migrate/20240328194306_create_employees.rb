class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.integer :employee_id
      t.string :first_name
      t.string :last_name
      t.string :role
      t.references :company, null: false, foreign_key: true
      t.integer :manager
      t.string :phone_number
      t.boolean :has_sms
      t.string :profile_picture
      t.string :time_zone

      t.timestamps
    end
  end
end
