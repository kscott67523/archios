module ApplicationHelper
  def clock_status(employee)
    if employee.timesheet_entries.present?
      latest_entry = employee.timesheet_entries.last
      if latest_entry.ended_at.nil?
        "<span class='badge bg-success'>Clocked in</span> #{latest_entry.started_at.strftime("%I:%M %p")}"
      else
        "<span class='badge bg-danger'>Clocked out</span> #{latest_entry.ended_at.strftime("%I:%M %p")}"
      end
    else
      "<span class='badge bg-secondary'>No timesheet entries</span>"
    end
  end

  def badge_color(status_text)
    case status_text
    when "Available"
      "success"
    when "Deep Focus"
      "warning"
    when "Away from Desk"
      "danger"
    else
      "danger"
    end
  end

  def timesheet_badge_color(entry_approval_status)
    case entry_approval_status
    when "approved"
      "success"
    when "pending"
      "warning"
    else
      "danger"
    end
  end

end
