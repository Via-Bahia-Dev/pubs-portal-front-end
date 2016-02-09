module ApplicationHelper
  include SessionsHelper
  include CommentsHelper

  def field_class(resource, field_name)
    if resource.errors[field_name].present?
      return "has-error".html_safe
    else
      return "".html_safe
    end
  end

  # Displays object errors
  def form_errors_for(object=nil)
    render('layouts/form_errors', object: object) unless object.blank?
  end

  # Displays errors like object errors but when given json
  def errors_from_json(json)
    render('layouts/json_errors', errors: json ) unless json.blank?
  end

  def date_from(datetime_string)
    match = /(\d{4})-(\d{2})-(\d{2})/.match(datetime_string)
    "#{match[2]}/#{match[3]}/#{match[1]}"
  end

  def datetime_from(datetime_string)
    zone = ActiveSupport::TimeZone.new(cookies["jstz_time_zone"])
    DateTime.parse(datetime_string).in_time_zone(zone)
  end

  def file_size_string(bytes)
    abbreviations = { 0 => "B", 1 => "KB", 2 => "MB", 3 => "GB" } # byte abbreviation to used, keyed by the number of times we square 1000
    times_to_square = (bytes.to_s.chars.length-1) / 3 # number of times we want to squre 1000 to divide our number by
    "#{(bytes / (1000.0 ** times_to_square)).round(2)} #{abbreviations[times_to_square]}"
  end

  def remove_hash(hex_color)
    hex_color[1..-1]
  end

  def hex_color_to_int(hex)
    if(hex[0] == '#')
      hex = remove_hash(hex)
    end
    hex.to_i(16)
  end

  def int_color_to_hex(int)
    int.to_s(16).rjust(6, '0')
  end

  def xeditable? object = nil
    can?(:edit, object) ? true : false
  end

end
