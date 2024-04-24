# frozen_string_literal: true

module ApplicationHelper
  def clock_status(employee)
    if employee.clocked_in?
      "<span class='badge bg-success'>Clocked in</span> #{employee.last_entry.started_at.strftime("%I:%M %p")}".html_safe
    elsif !employee.clocked_in? && employee.last_entry.present?
      "<span class='badge bg-danger'>Clocked out</span> #{employee.last_entry.ended_at.strftime("%I:%M %p")}".html_safe
    else
      "<span class='badge bg-secondary'>No timesheet entries</span>".html_safe
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

  def has_tmail_status(employee)
    if employee.has_tmail?
      "<span class='badge bg-warning'>t-mail user</span>".html_safe
    else
      "<span class='badge bg-danger'>t-mail not activated</span>".html_safe
    end
  end
end
