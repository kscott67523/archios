# frozen_string_literal: true

desc "Fill the database tables with some sample data"
task sample_data: :environment do
  started_at = Faker::Date.backward(days: 7)
  ended_at = Faker::Date.forward(days: 7)
  name = Faker::Movies::HarryPotter.spell

  # Define a range for the typical work hours in a day
  WORK_HOURS_RANGE = (4..10)

  # Generate timesheet entries for Bob
  Employee.all.each do |employee|
    20.times do
      started_at = Faker::Time.between(from: PayPeriod.current.started_at, to: PayPeriod.current.ended_at)

      # Determine the duration of the shift
      shift_duration = rand(WORK_HOURS_RANGE).hours

      # Make sure the shift doesn't exceed the pay period's end
      ended_at = [started_at + shift_duration, PayPeriod.current.ended_at].compact.min

      previous_entry = employee.timesheet_entries.last

      if previous_entry && previous_entry.ended_at.nil?
        # If the previous entry hasn't ended, end it randomly within the typical range
        random_end_time = (previous_entry.started_at + rand(4..8).hours)
        previous_entry.update!(ended_at: random_end_time)
        previous_entry.calculate_hours_worked
      else
        # Create a new entry with calculated start and end times
        TimesheetEntry.create!(
          employee_id: employee.id,
          started_at: started_at,
          ended_at:,
          entry_approval_status: (ended_at.nil? ? "pending" : %w[approved rejected].sample),
          pay_period_id: PayPeriod.current.id,
        )
      end
    end
  end
  puts "#{TimesheetEntry.count} timesheet entries have been created."
end
