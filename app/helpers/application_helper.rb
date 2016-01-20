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

end
