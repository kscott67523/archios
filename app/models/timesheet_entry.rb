# == Schema Information
#
# Table name: timesheet_entries
#
#  id                    :bigint           not null, primary key
#  comments              :text
#  ended_at              :datetime
#  entry_approval_status :string
#  hours_worked          :decimal(, )
#  started_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  employee_id           :bigint           not null
#  pay_period_id         :bigint
#
# Indexes
#
#  index_timesheet_entries_on_employee_id    (employee_id)
#  index_timesheet_entries_on_pay_period_id  (pay_period_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (pay_period_id => pay_periods.id)
#
class TimesheetEntry < ApplicationRecord
  enum entry_approval_status: { pending: "pending", approved: "approved", rejected: "rejected" }, _default: "approved"
  belongs_to :employee
  belongs_to :pay_period, class_name: "PayPeriod", foreign_key: :pay_period_id
  has_one :manager, through: :employee
  has_one :approver, through: :manager, source: :manager

  validates :employee_id, presence: true
  validates :started_at, presence: true
  validates :entry_approval_status, presence: true
  validate :end_time_after_start_time, if: -> { started_at.present? && ended_at.present? }

  scope :approved_entries, -> { where(entry_approval_status: :approved) }
  scope :rejected_entries, -> { where(entry_approval_status: :rejected) }
  scope :submitted_entries, -> { where(entry_approval_status: :submitted) }
  scope :current, -> { where(pay_period_id: PayPeriod.last.id) }

  def calculate_hours_worked
    return 0 if ended_at == nil
    duration_seconds = (ended_at - started_at)
    duration_hours = duration_seconds.to_f / 3600
    hours_worked = duration_hours.round(2) # Round to two decimal places
    update_columns(hours_worked: hours_worked, entry_approval_status: "pending")
  end

  private

  def end_time_after_start_time
    errors.add(:ended_at, "must be after start time") if ended_at <= started_at
  end
end
