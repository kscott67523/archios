# == Schema Information
#
# Table name: employees
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  has_tmail              :boolean
#  last_name              :string
#  phone_number           :string
#  profile_picture        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  status                 :string           default("What are you up to?")
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
  scope :managers, -> { where(role: roles[:manager]) }

  def dashboard
    { first_name: full_name,
      company_name: company.name,
      profile_picture_url: profile_picture? ? Rails.application.routes.url_helpers.url_for(profile_picture) : nil,
      time_zone: time_zone,
      role: role,
      manager: manager.present? ? Rails.application.routes.url_helpers.url_for(manager.full_name) : nil,
      current_timesheet: current_timesheet.map(&:attributes) }
  end

  def current_timesheet
    today = Date.today
    pay_period = PayPeriod.find_by("started_at <= ? AND ended_at >= ?", today, today)

    return {} if pay_period.nil?

    timesheet_entries.joins(:pay_period)
      .select("timesheet_entries.*, pay_periods.started_at AS pay_period_started_at, pay_periods.ended_at AS pay_period_ended_at")
      .where(pay_periods: { id: pay_period.id })
      .order("timesheet_entries.created_at ASC")
  end

  def total_hours_worked
    timesheet_entries.current.sum { |entry| entry.hours_worked || 0 }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_default_has_sms
    self.has_sms ||= false
  end
end
