module APIHelper
  # include HTTParty

  def get(url)
    check_success(self.class.get(url, :headers => auth_headers))
  end

  def post(url, params = {})
    check_success(self.class.post(url, :query => params, :headers => auth_headers, :detect_mime_type => true ))
  end

  def put(url, params = {})
    self.class.put(url, :query => params, :headers => auth_headers, :detect_mime_type => true )
  end

  def delete(url, params = {})
    self.class.delete(url, :query => params, :headers => auth_headers, :detect_mime_type => true )
  end

  private
  # checks if the response was successful and returns the appropriate json
  def check_success(res)
    if res.success?
      res.parsed_response["data"]
    elsif res.code == 403
      render :file => "layouts/unauthorized", status: :unauthorized
    else
      res
    end
  end
end
