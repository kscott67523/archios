# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  logo       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  has_many :employees
  has_many :managers, -> { where(role: :manager) }, class_name: "Employee"

  validates :name, presence: true
end
