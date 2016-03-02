module TemplatesHelper

  # For default form_for, select uses [ text, value ]
  def get_tag_select_options(user_role = nil)
    @tags = get("/tags")
    @tag_options = @tags.map { |tag| tag["name"] }
  end

  # For x editable plugin, select2 uses { id: value, text: text }
  def get_tag_editable_select_options(user_role = nil)
    @tags = get("/tags")
    @tag_options = @tags.map { |tag| { id: tag["name"], text: tag["name"] } }
  end
end
