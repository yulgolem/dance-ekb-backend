module HTTPRequestHelper
  def default_request_response(url, body, headers, type = :post)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = "Net::HTTP::#{type.to_s.titleize}".constantize.new(uri.request_uri)
    headers&.each { |key, val| request[key] = val }
    request.body = body.to_json if body
    response = http.request(request)
    parsed_response = JSON.parse(response.read_body).with_indifferent_access
    unless response.code.starts_with? "2"
      ErrorTracker.new(
        message: "HTTP request failed",
        payload: {
          url: url,
          body: body,
          headers: headers,
          type: type,
          response: parsed_response,
        },
        silent: true
      )
    end
    parsed_response
  end

  def default_post_request_response(url, body = nil, headers = nil)
    default_request_response(url, body, headers, :post)
  end

  def default_get_request_response(url, body = nil, headers = nil)
    default_request_response(url, body, headers, :get)
  end
end
