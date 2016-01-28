module RequestAttachmentsHelper

  def is_image_file?(content_type)
    /\Aimage\/.*\Z/.match(content_type) ? true : false
  end

end
