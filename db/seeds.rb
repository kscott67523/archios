# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a company with random data using Faker gem
company = Company.create!(
  name: Faker::TvShows::Simpsons.location,
  logo: Faker::Company.logo
)

puts "#{Company.count} companies have been created."

# Generate sample data for the employees table
yoli = Employee.create!(
  first_name: "Yoli",
  last_name: Faker::Name.last_name,
  role: :manager,
  company_id: company.id,
  manager_id: nil, # Assign the manager id to the first employee
  phone_number: Faker::Number.number(digits: 10),
  profile_picture: "https://pbs.twimg.com/media/FMarwB5WUAUBYgz.jpg:large", # Using Faker::LoremPixel
  time_zone: Faker::Address.time_zone,
  email: "kqscott19@gmail.com",
  password: "password",
)

bob = Employee.create!(
  first_name: "Bob",
  last_name: Faker::Name.last_name,
  role: :employee,
  company_id: company.id, # Assuming there are 5 companies
  manager_id: yoli.id, # Assign the manager id to the first employee
  phone_number: Faker::Number.number(digits: 10),
  profile_picture: "https://hips.hearstapps.com/hmg-prod/images/gettyimages-1239961811.jpg?crop=0.668xw:1.00xh;0.250xw,0&resize=640:*",
  time_zone: Faker::Address.time_zone,
  email: "bob@example.com",
  password: "password",
)

puts "#{Employee.count} employees have been created."

# Create a new pay period with random data using Faker gem
current_pay_period = PayPeriod.create!(
  started_at: Faker::Date.backward(days: 7),
  ended_at: Faker::Date.forward(days: 7),
  name: Faker::Movies::HarryPotter.spell,
)

# Define a range for the typical work hours in a day
WORK_HOURS_RANGE = (4..10)

# Generate timesheet entries for Bob
20.times do
  comments = [Faker::Lorem.sentence, ''].sample
  started_at = Faker::Time.between(from: current_pay_period.started_at, to: current_pay_period.ended_at)

  # Determine the duration of the shift
  shift_duration = rand(WORK_HOURS_RANGE).hours

  # Make sure the shift doesn't exceed the pay period's end
  ended_at = [started_at + shift_duration, current_pay_period.ended_at].compact.min

  previous_entry = bob.timesheet_entries.last

  if previous_entry && previous_entry.ended_at.nil?
    # If the previous entry hasn't ended, end it randomly within the typical range
    random_end_time = (previous_entry.started_at + rand(4..8).hours)
    previous_entry.update!(ended_at: random_end_time)
    previous_entry.calculate_hours_worked
  else
    # Create a new entry with calculated start and end times
    TimesheetEntry.create!(
      employee_id: bob.id,
      started_at:,
      ended_at:,
      comments:,
      entry_approval_status: (ended_at.nil? ? "pending" : %w[approved rejected].sample),
      pay_period_id: current_pay_period.id,
    )
  end
end
puts "#{TimesheetEntry.count} timesheet entries have been created."

TmailSubscription.create!(
  employee_id: yoli.id
)

TmailSubscription.create!(
  employee_id: bob.id
)
