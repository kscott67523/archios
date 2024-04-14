class AddEmailToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :email, :string
  end
end
