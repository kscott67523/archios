# frozen_string_literal: true

# == Schema Information
#
# Table name: requests
#
#  id           :bigint           not null, primary key
#  email        :string
#  request_body :text
#  status       :integer          default(NULL)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Request < ApplicationRecord
  # Associations
  # belongs_to :timesheet_entry, foreign_key: 'timesheet_entry_id'

  # Enumerations
  enum status: { pending: 'pending', successful: 'successful', denied: 'denied' }

  # Validations
  validates :request_body, presence: true
  # delete unused code
  # validates :timesheet_entry_id, presence: true
end
