module PublicationRequestsHelper

  def get_user_options
    @admins_options    = get_user_select_options("admins")
    @designers_options = get_user_select_options("designers")
    @reviewers_options = get_user_select_options("reviewers")
  end

  def get_user_editable_options
    @admins_options    = get_user_editable_select_options("admins")
    @designers_options = get_user_editable_select_options("designers")
    @reviewers_options = get_user_editable_select_options("reviewers")
  end

  def format_request_param_dates(params)
    params[:publication_request].each do |param, value|
      if param == 'rough_date' || param == 'due_date' || param == 'event_date'
        params[:publication_request][param] = date_obj_from(value)
      end
    end
  end

end
