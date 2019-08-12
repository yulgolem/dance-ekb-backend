module VKAuthHelper
  include HTTPRequestHelper

  def get_user_info(payload)
    url = [
      "https://api.vk.com/method/users.get?",
      "user_ids=#{payload[:user_id]}",
      "&fields=name,email",
      "&access_token=#{payload[:access_token]}",
      "&v=#{Settings.vk.api_version}",
    ].join

    response = default_post_request_response(url)

    if response[:response] && response[:response][0]
      # successful response example
      # {
      #   response: [
      #     {
      #       id: 528693184,
      #       first_name: "Nikita",
      #       last_name: "Krivov",
      #       is_closed: true,
      #       can_access_closed: true
      #     }
      #  ]
      # }

      response = response[:response][0]
      {
        first_name: response[:first_name],
        last_name: response[:last_name],
        user_id: response[:id],
      }
    else
      # error response example, wrong access_token provided
      # {
      #   error: {
      #     error_code: 5,
      #     error_msg: "User authorization failed: invalid access_token (4).",
      #     request_params: [
      #       {
      #         key: "oauth",
      #         value: "1"
      #       },
      #       {
      #         key: "method",
      #         value: "users.get"
      #       },
      #       {
      #         key: "user_ids",
      #         value: "528693184"
      #       },
      #       {
      #         key: "fields",
      #         value: "name"
      #       },
      #       {
      #         key: "v",
      #         value: "5.92"
      #       }
      #     ]
      #   }
      # }

      ErrorTracker.new(
        message: "VK user info obtain failed",
        payload: {vk_response: response}, silent: true
      )
      {}
    end
  end

  def get_payload_by_vk_code(vk_code)
    url = [
      "https://oauth.vk.com/access_token?",
      "client_id=#{Settings.vk.app_id}",
      "&client_secret=#{Rails.application.secrets.vk_app_secret_key}",
      "&redirect_uri=#{Settings.vk.redirect_uri}",
      "&code=#{vk_code}",
    ].join

    # success response example
    # {
    #   access_token: "10166132906ab28db950d92488cb5912caf0c6ad75950003abc880330c01a2f0e45912a83cf3dab34f5f2",
    #   expires_in: 86386,
    #   user_id: 528693184
    # }

    # error response example
    # {
    #   error: "invalid_grant",
    #   error_description: "Code is invalid or expired."
    # }

    default_post_request_response(url)
  end
end
