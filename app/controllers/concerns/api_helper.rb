module APIHelper
  # include HTTParty
  
  def get(url)
    res = self.class.get(url, :headers => auth_headers)
    if res.success?
      res.parsed_response["data"]
    else
      res
    end
  end

  def post(url, params)
    res = self.class.post(url, :query => params, :headers => auth_headers, :detect_mime_type => true )
    if res.success?
      res.parsed_response["data"]
    else
      res
    end
  end

  def put(url, params)
    res = self.class.put(url, :query => params, :headers => auth_headers, :detect_mime_type => true )
    if res.success?
      res.parsed_response["data"]
    else
      res
    end
  end 

end