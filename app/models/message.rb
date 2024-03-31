# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  message       :string
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  sender_id     :integer          not null
#  time_entry_id :integer          not null
#
# Indexes
#
#  index_messages_on_sender_id      (sender_id)
#  index_messages_on_time_entry_id  (time_entry_id)
#
class Message < ApplicationRecord
  enum status: { pending: "pending", updated: "updated", unchanged: "unchanged" }
  enum message_type: { clock_in: "clock in", clock_out: "clock out" }

  belongs_to :sender, class_name: "Employee", foreign_key: :employee_id
  belongs_to :approver, class_name: "Employee", foreign_key: :manager_id
  has_many :time_entries, class_name: "TimesheetEntry", foreign_key: :time_entry_id

  validates :sender_id, presence: true
  validates :message, presence: true
  validates :status, presence: true
  validates :time_entry_id, presence: true
end
