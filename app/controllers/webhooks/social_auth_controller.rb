module Webhooks
  class SocialAuthController < ApplicationController
    include VKAuthHelper
    layout false

    def vk_oauth_handler
      # DRAFT VK Authorization Code Flow implementation
      # vk_identity = Accounts::VKIdentity.find_or_initialize_by state: vk_params[:state]
      # # TODO use cached state if value no Account matched it (initial auth flow)
      # if vk_params[:code].present?
      #   vk_identity.update! auth_status: :code_received,
      #                       code: vk_params[:code]
      # elsif vk_params[:error].present? || vk_params[:error_description].present?
      #   vk_identity.update! auth_status: :error,
      #                       error: vk_params[:error],
      #                       error_description: vk_params[:error_description]
      # else
      #   ErrorTracker.new(
      #     message: 'Unsupported redirect vk params',
      #     payload: { vk_params: vk_params },
      #     silent: true
      #   )
      # end
      # https://oauth.vk.com/authorize?client_id=6836209&display=touch&redirect_uri=https://97b526e8.ngrok.io/webhooks/social_auth/vk_oauth_handler&scope=email&response_type=code&v=5.95
      @vk_params = vk_params.to_h
      if @vk_params[:code].present?
        @vk_params.merge! get_payload_by_vk_code(@vk_params[:code])
      end
      if @vk_params[:access_token].present?
        if @vk_params[:first_name].blank? ||
            @vk_params[:last_name].blank? ||
            @vk_params[:user_id].blank?
          @vk_params.merge! get_user_info(@vk_params)
        end
      end
      render "webhooks/vk_oauth_handler"
    end

    def facebook_oauth_handler
      render "webhooks/facebook_oauth_handler"
    end

    private

    def vk_params
      params.permit(
        :code,
        :access_token,
        :user_id,
        :email,
        :expires_in,
        :state,
        :error,
        :error_description
      )
    end

    def facebook_params
      params.permit!
    end
  end
end
