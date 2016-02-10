module UsersHelper

  def get_users_by_role(user_role = nil)
    if user_role == nil
      get("/users")
    else
      get("/users/#{user_role}")
    end
  end

  # For default form_for, select uses [ text, value ]
  def get_user_select_options(user_role = nil)
    users = get_users_by_role(user_role)
    users.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }
  end

  # For x editable plugin, select uses { value => text }
  def get_user_editable_select_options(user_role = nil)
    users = get_users_by_role(user_role)
    users.map { |user| {  user['id'] => "#{user['first_name']} #{user['last_name']}" } }
  end

end
