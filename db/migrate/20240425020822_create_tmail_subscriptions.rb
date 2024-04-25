class CreateTmailSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :tmail_subscriptions do |t|
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
