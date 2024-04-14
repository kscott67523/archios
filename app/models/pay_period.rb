# frozen_string_literal: true

# == Schema Information
#
# Table name: pay_periods
#
#  id         :bigint           not null, primary key
#  ended_at   :date
#  name       :string
#  started_at :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PayPeriod < ApplicationRecord
  has_many :timesheet_entries

  def self.current
    today = Date.today
    find_by('started_at <= ? AND ended_at >= ?', today, today)
  end
end
