# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a company with random data using Faker gem
# db/seeds.rb
desc "Fill the database tables with some sample data"
task sample_data: :environment do
  if Rails.env.development?
    TimesheetEntry.destroy_all
    PayPeriod.destroy_all
    Request.destroy_all
    Status.destroy_all
    Employee.destroy_all
    Company.destroy_all
    # Create a new company
    company = Company.create!(
      name: Faker::Company.name,
      logo: Faker::Company.logo,
    )

    puts "#{Company.count} companies have been created."

    # Generate sample data for employees
    bob = Employee.create!(
      first_name: "Bob",
      last_name: Faker::Name.last_name,
      role: :manager,
      company: company, # Assign the company directly
      phone_number: Faker::Number.number(digits: 10),
      has_tmail: [true, false].sample,
      profile_picture: Faker::LoremFlickr.image(size: "50x50"),
      time_zone: Faker::Address.time_zone,
      email: "bob@example.com",
      password: "password",
    )

    alice = Employee.create!(
      first_name: "Alice",
      last_name: Faker::Name.last_name,
      role: :employee,
      company: company, # Assign the company directly
      manager: bob, # Assign the manager directly
      phone_number: Faker::Number.number(digits: 10),
      has_tmail: [true, false].sample,
      profile_picture: Faker::LoremFlickr.image(size: "50x50"),
      time_zone: Faker::Address.time_zone,
      email: "alice@example.com",
      password: "password",
    )

    puts "#{Employee.count} employees have been created."

    # Create a new pay period
    current_pay_period = PayPeriod.create!(
      started_at: Faker::Date.backward(days: 7),
      ended_at: Faker::Date.forward(days: 7),
    )

    # Generate sample timesheet entries for Alice
    20.times do
      comments = [Faker::Lorem.sentence, ""].sample
      started_at = Faker::Time.between(from: current_pay_period.started_at, to: current_pay_period.ended_at)

      ended_at = [(started_at + rand(1..8).hours), nil].sample
      previous_entry = alice.timesheet_entries.last

      if previous_entry && previous_entry.ended_at.nil?
        random_end_time = (previous_entry.started_at + rand(4..8).hours)
        previous_entry.update!(ended_at: random_end_time)
        previous_entry.calculate_hours_worked
      else
        TimesheetEntry.create!(
          employee: alice,
          started_at: started_at,
          ended_at: ended_at,
          comments: comments,
          entry_approval_status: "approved",
          pay_period: current_pay_period, # Assign the pay period directly
        )
      end
    end
    puts "#{TimesheetEntry.count} timesheet entries have been created."
  end
end
