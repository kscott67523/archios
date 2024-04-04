class AddPayPeriodTable < ActiveRecord::Migration[7.0]
  def change
    create_table :pay_periods do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.timestamps
    end
  end
end
