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
end
