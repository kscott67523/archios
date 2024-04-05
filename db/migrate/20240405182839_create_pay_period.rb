class CreatePayPeriod < ActiveRecord::Migration[7.0]
  def change
    create_table :pay_periods do |t|
      t.date :started_at
      t.date :ended_at
      t.string :name

      t.timestamps
    end
  end
end
