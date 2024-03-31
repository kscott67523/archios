# == Schema Information
#
# Table name: timesheet_entries
#
#  id                    :integer          not null, primary key
#  comments              :text
#  ended_at              :datetime
#  entry_approval_status :string
#  hours_worked          :decimal(, )
#  started_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  employee_id           :integer          not null
#
# Indexes
#
#  index_timesheet_entries_on_employee_id  (employee_id)
#
class TimesheetEntry < ApplicationRecord

  enum entry_approval_status: { pending: "pending", approved: "approved", rejected: "rejected" }

  belongs_to :employee
  has_one :manager, through: :employee
  has_one :approver, through: :manager, source: :manager

  validates :employee_id, presence: true
  validates :started_at, presence: true
  validates :entry_approval_status, presence: true
  validate :end_time_after_start_time, if: -> { started_at.present? && ended_at.present? }

  attribute :ended_at, :datetime, default: -> { Time.current }

  scope :approved_entries, -> { where(entry_approval_status: :approved) }
  scope :pending_entries, -> { where(entry_approval_status: :pending) }
  scope :rejected_entries, -> { where(entry_approval_status: :rejected) }

  def hours_worked
    return nil if started_at.nil? || ended_at.nil?

    duration_seconds = (ended_at - started_at).to_i
    duration_hours = duration_seconds.to_f / 3600
    duration_hours.round(2) # Round to two decimal places
  end
  
  private

  def end_time_after_start_time
    errors.add(:ended_at, "must be after start time") if ended_at <= started_at
  end
end
