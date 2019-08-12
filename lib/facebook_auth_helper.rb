module FacebookAuthHelper
  include HTTPRequestHelper

  def debug_facebook_token(access_token)
    url = [
      "https://graph.facebook.com/",
      "v#{Settings.facebook.api_version}/",
      "debug_token?",
      "input_token=#{access_token}",
      "&access_token=#{Rails.application.secrets.facebook_app_access_token}",
      "&appsecret_proof=#{facebook_appsecret_proof(access_token)}",
      # "&suppress_http_code=1&format=json&method=get&pretty=0&debug=all&transport=cors"
    ].join
    payload = default_get_request_response(url)
    payload[:data] && payload[:data][:is_valid] ? payload[:data] : payload
  end

  def get_facebook_payload(user_id, access_token)
    url = [
      "https://graph.facebook.com/",
      "v#{Settings.facebook.api_version}/",
      "#{user_id}?",
      "fields=name,email",
      "&access_token=#{access_token}",
      "&appsecret_proof=#{facebook_appsecret_proof(access_token)}",
      "&suppress_http_code=1",
    ].join
    default_get_request_response(url)
  end

  def facebook_appsecret_proof(access_token)
    OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new("sha256"),
      Rails.application.secrets.facebook_app_secret,
      access_token
    )
  end
end
