require "tabulo"
Pry.config.print = proc do |output, value, _pry_|
  case value
  when ActiveRecord::Relation
    row_count = value.count

    max_rows_to_display_at_once = 5
    num_rows_to_frame_with = 2
    
    column_names_to_exclude =  [:created_at, :updated_at]
    column_names = value.column_names.map(&:to_sym) - column_names_to_exclude
    
    header_frequency = 10
    border_style = :markdown

    table_options = {
      header_frequency: header_frequency,
      border: border_style,
      wrap_body_cells_to: 1,
      truncation_indicator: "…"
    }

    if row_count > max_rows_to_display_at_once
      output.puts Tabulo::Table.new(value.limit(num_rows_to_frame_with), *column_names, table_options).pack

      output.puts
      output.puts "(... #{row_count - 2*num_rows_to_frame_with} more rows between ...)"
      output.puts

      output.puts Tabulo::Table.new(value.offset(row_count - num_rows_to_frame_with).limit(num_rows_to_frame_with), *column_names, table_options).pack
    else
      output.puts Tabulo::Table.new(value, *column_names, table_options).pack
    end

    output.puts
    output.puts "=> #{value.to_s}"
    output.puts
  when Class
    Pry::ColorPrinter.default(output, value, _pry_)

    output.puts
    output.puts("The #{value} class itself.")
  else
    Pry::ColorPrinter.default(output, value, _pry_)
    
    output.puts
    output.puts("An instance of the #{value.class} class.")
  end
end
