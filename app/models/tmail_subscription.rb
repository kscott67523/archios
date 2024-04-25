# == Schema Information
#
# Table name: tmail_subscriptions
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :bigint           not null
#
# Indexes
#
#  index_tmail_subscriptions_on_employee_id  (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#
class TmailSubscription < ApplicationRecord
  belongs_to :employee
end
