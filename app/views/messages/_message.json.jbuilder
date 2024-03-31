json.extract! message, :id, :sender_id, :message, :status, :time_entry_id, :our_response, :created_at, :updated_at
json.url message_url(message, format: :json)
