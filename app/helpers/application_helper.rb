module ApplicationHelper
	include SessionsHelper

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

end
