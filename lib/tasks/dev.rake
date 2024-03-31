desc "Fill the database tables with some sample data"
task sample_data: :environment do
  if Rails.env.development?
    Company.destroy_all
    Employee.destroy_all
    Message.destroy_all
    TimesheetEntry.destroy_all

    company = Company.new(
      name: Faker::Company.name,
      logo: Faker::Company.logo,
    )

    puts "#{Company.count} companies have been created."

    # Generate sample data for the employees table
    bob = Employee.new(
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
      password: "password"
    )
    puts "#{Employee.count} employees have been created."

    # Generate sample data for the timesheet_entries table
    timesheet_entry_count = 20
    timesheet_entry_count.times do
      started_at = Faker::Time.backward(hours: 8)
      ended_at = Faker::Time.forward(hours: 8)
      TimesheetEntry.create!(
        employee_id: alice.id,
        started_at: Faker::Time.backward(days: 1),
        ended_at: Faker::Time.forward(days: 1),
        comments: Faker::Lorem.sentence,

        entry_approval_status: ["approved", "pending", "rejected"].sample,
      )
    end
    puts "#{TimesheetEntry.count} timesheet entries have been created."

    puts "Sample data has been successfully generated."
  else
    puts "This task can only be run in the development environment."
  end
end
