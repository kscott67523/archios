# == Schema Information
#
# Table name: requests
#
#  id                 :bigint           not null, primary key
#  request_body       :text
#  request_type       :string
#  status             :integer          default(NULL)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  timesheet_entry_id :bigint           not null
#
# Indexes
#
#  index_requests_on_timesheet_entry_id  (timesheet_entry_id)
#
# Foreign Keys
#
#  fk_rails_...  (timesheet_entry_id => timesheet_entries.id)
#
class Request < ApplicationRecord
  # Associations
  belongs_to :timesheet_entry, foreign_key: "timesheet_entry_id"
  
  # Enumerations
  enum status: { pending: "pending", successful: "successful", denied: "denied" }
  
  # Validations
  validates :request_type, presence: true
  validates :request_body, presence: true
  validates :timesheet_entry_id, presence: true
end
