# == Schema Information
#
# Table name: employees
#
#  id                     :integer          not null, primary key
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
#  company_id             :integer          not null
#  manager_id             :integer
#
# Indexes
#
#  index_employees_on_company_id            (company_id)
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_manager_id            (manager_id)
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
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
  belongs_to :manager, class_name: 'Employee', foreign_key: :manager_id, optional: true
  has_many :timesheet_entries
  has_many :messages, foreign_key: :sender_id

  private

  def set_default_has_sms
    self.has_sms ||= false
  end
end
