# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  has_sms                :boolean
#  last_name              :string
#  phone_number           :string
#  profile_picture        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  time_zone              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint           not null
#  manager_id             :integer
#
# Indexes
#
#  index_employees_on_company_id            (company_id)
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enum for role
  enum role: { manager: "manager", employee: "employee" }

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validates :company_id, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :time_zone, presence: true

  # Associations
  belongs_to :company
  belongs_to :manager, class_name: "Employee", foreign_key: :manager_id, optional: true
  has_many :timesheet_entries, class_name: "TimesheetEntry", foreign_key: :employee_id
  has_many :messages, foreign_key: :sender_id
  has_many :employees, class_name: "Employee", foreign_key: "manager_id"
  has_one :status, foreign_key: :employee_id
  has_one :tmail_subscription, class_name: "TmailSubscription", foreign_key: "employee_id"

  scope :managers, -> { where(role: roles[:manager]) }

  def dashboard
    { first_name: full_name,
      company_name: company.name,
      profile_picture_url: profile_picture? ? Rails.application.routes.url_helpers.url_for(profile_picture) : nil,
      time_zone:,
      role:,
      manager: manager.present? ? Rails.application.routes.url_helpers.url_for(manager.full_name) : nil,
      current_timesheet: current_timesheet.map(&:attributes) }
  end

  def current_timesheet
    today = Date.today
    pp = PayPeriod.current

    return {} if pp.nil?

    timesheet_entries.where(pay_period_id: pp.id)
  end

  def total_hours_worked
    timesheet_entries.current.sum { |entry| entry.hours_worked || 0 }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def clocked_in?
    last_entry = timesheet_entries.last
    last_entry.present? && last_entry.ended_at.nil?
  end

  def clock_in
    return if clocked_in? # Don't allow clocking in if already clocked in
    timesheet_entries.create(started_at: Time.now)
  end

  # Method to clock out
  def clock_out
    return unless clocked_in? # Don't allow clocking out if not clocked in
    last_entry = timesheet_entries.last
    last_entry.update(ended_at: Time.now)
  end

  def last_entry
    timesheet_entries.last
  end

  def has_tmail?
    tmail_subscription.present?
  end
end
