# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  text        :string           default("What are you up to?")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :bigint
#
# Indexes
#
#  index_statuses_on_employee_id  (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#
class Status < ApplicationRecord
  belongs_to :employee, class_name: "Employee", foreign_key: :employee_id
end
