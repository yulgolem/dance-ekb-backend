class APIController < ApplicationController
  include JSONAPI::ActsAsResourceController

  before_action :skip_session

  on_server_error :send_to_rollbar

  def append_info_to_payload(payload = {})
    super
    payload[:uid] = current_admin&.id
  end

  def current_ability
    @current_ability ||= ::AdminAbility.new(preview_access_token: request.headers["Preview-Access-Token"].presence || params[:'preview-access-token'])
  end

  # def handle_exceptions(e)
  #   case e
  #     when JSONAPI::Exceptions::Error
  #       render_errors(e.errors)
  #     else
  #       Rails.logger.info 'handle_exceptions'
  #       send_to_rollbar(e)
  #       internal_server_error = JSONAPI::Exceptions::InternalServerError.new(e)
  #       Rails.logger.error { "Internal Server Error: #{e.message} #{e.backtrace.join("\n")}" }
  #       render_errors(internal_server_error.errors)
  #   end
  # end

  private

  # def current_user
  #   raise 'DEBUG' unless Rails.env.development?
  #   User.find(1)
  # end

  def skip_session
    request.session_options[:skip] = true
  end

  def context
    {
      action: params[:action],
      current_ability: current_ability,
      current_user: current_admin,
      remote_ip: request.remote_ip,
      region_slug: request.headers["region"],
    }
  end

  def resource_serializer_klass
    @resource_serializer_klass ||= APISerializer
  end
end
