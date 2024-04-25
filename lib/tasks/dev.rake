# frozen_string_literal: true

desc "Fill the database tables with some sample data"
task sample_data: :environment do
  if Rails.env.development?
    TimesheetEntry.destroy_all
    PayPeriod.destroy_all
    Request.destroy_all
    TmailSubscription.destroy_all
    Employee.destroy_all
    Company.destroy_all
  end
end
