class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  respond_to :json

  serialization_scope nil # removing this will break sign in, see https://github.com/lynndylanhurley/devise_token_auth/issues/685

  def current_ability
    # @current_ability ||= AdminAbility.new(admin: current_admin)
  end

  def self.send_to_rollbar(error)
    Rails.logger.info "Trying to send error to rollbar"
    if defined?(Rollbar)
      Rollbar.error(error)
    end
    if Rails.env.test?
      puts error.message
      puts error.backtrace.join("\n")
    end
  end

  protected

  def disable_nginx_cache
    nginx_cache_duration 0
  end

  def nginx_cache_duration(expires_in)
    response.headers["X-Accel-Expires"] = expires_in.to_i.to_s
  end

  def tracking_meta
    @tracking_meta ||= {
      otclick_meta: request.headers["otclick-meta"],
      landing_data: request.headers["Landing-Data"],
      referral_code: request.headers["Referral-Code"],
      current_data: {
        ip: request.remote_ip,
        user_agent: request.user_agent,
        referer: request.user_agent,
      },
    }
  end

  def info_for_paper_trail
    {ip: request.remote_ip}
  end

  def parsed_tracking_meta
    @parsed_tracking_meta ||= tracking_meta.merge(
      landing_data: (begin
                         ActiveSupport::JSON.decode(tracking_meta[:landing_data])
                     rescue
                       nil
                       end)
    ).delete_if { |k, v| v.blank? }
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      # here comes user parameters
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      # here comes user parameters
    ])
  end
end
