desc "Fill the database tables with some sample data"
task sample_data: :environment do
  if Rails.env.development?
    TimesheetEntry.destroy_all
    PayPeriod.destroy_all
    Request.destroy_all
    Status.destroy_all
    Employee.destroy_all
    Company.destroy_all

    company = Company.create!(
      name: Faker::Company.name,
      logo: Faker::Company.logo,
    )

    puts "#{Company.count} companies have been created."

    # Generate sample data for the employees table
    bob = Employee.create!(
      first_name: "Bob",
      last_name: Faker::Name.last_name,
      role: :manager,
      company_id: company.id,
      manager_id: nil, # Assign the manager id to the first employee
      phone_number: Faker::Number.number(digits: 10),
      has_sms: [true, false].sample,
      profile_picture: Faker::LoremFlickr.image(size: "50x50"), # Using Faker::LoremPixel
      time_zone: Faker::Address.time_zone,
      email: "bob@example.com",
      password: "password",
    )

    alice = Employee.create!(
      first_name: "Alice",
      last_name: Faker::Name.last_name,
      role: :employee,
      company_id: company.id, # Assuming there are 5 companies
      manager_id: bob.id, # Assign the manager id to the first employee
      phone_number: Faker::Number.number(digits: 10),
      has_sms: [true, false].sample,
      profile_picture: Faker::LoremFlickr.image(size: "50x50"),
      time_zone: Faker::Address.time_zone,
      email: "alice@example.com",
      password: "password",
    )

    puts "#{Employee.count} employees have been created."

    current_pay_period = PayPeriod.create!(
      started_at: Faker::Date.backward(days: 7),
      ended_at: Faker::Date.forward(days: 7),
    )

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
          employee_id: alice.id,
          started_at: started_at,
          ended_at: ended_at,
          comments: comments,
          entry_approval_status: "approved",
          pay_period_id: current_pay_period.id,
        )
      end
    end
    puts "#{TimesheetEntry.count} timesheet entries have been created."
  end
end
