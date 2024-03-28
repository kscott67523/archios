class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: true
      t.string :message
      t.string :status
      t.references :time_entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
