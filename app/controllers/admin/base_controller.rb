class Admin::BaseController < AdminController
  include ResourceUrlsConcern

  helper_method :resource_class, :nearest_index_url

  # before_action :get_last_active_cookie, only: %i[edit update create]

  # use "new:" prefix to indicate new object
  # INDICATE_NEW_PREFIX = 'new:'.freeze
  # CREATABLE_OBJECTS = [
  #   { attr: :xxx_ids, model_class: ::XXX },
  # ].freeze

  def self.load_crud_resource(options = {})
    load_and_authorize_resource({
      only: %i[show index new create edit update destroy],
      instance_name: "resource",
    }.merge(options))
  end

  # prepend_before_action :check_for_creatable_nested, only: %i[create update]
  prepend_before_action :redirect_from_slug, only: [:edit]

  def index
    page = [params[:page].to_i, 1].max
    per_page ||= (params[:no_pagination] ? @resources.count : (params[:per_page] || 100)).to_i
    @resources = @resources.page(page).per(per_page)
    @query = query_class.new params
    @resources = @query.scope @resources
  end

  def show
    return unless can? :update, @resource
    redirect_to action: :edit, id: params[:id]
  end

  def edit
  end

  def create
    if @resource.save
      flash[:notice] = t("controllers.flash.done")
    else
      flash[:error] = [
        t("controllers.flash.error"),
        @resource.errors.full_messages.join("\n"),
      ].join("\n").html_safe
    end
    respond_with :admin, @resource, location: after_create_location
  end

  def update
    if @resource.update(resource_params)
      flash[:notice] = t("controllers.flash.changes_are_saved") unless params[:sort]
    else
      flash[:error] = [
        t("controllers.flash.changes_are_not_saved"),
        @resource.errors.full_messages.join("\n"),
      ].join("\n").html_safe
    end
    yield if block_given?
    respond_with :admin, @resource, location: after_update_location
  end

  def destroy
    if @resource.destroy
      flash[:notice] = t("controllers.flash.delete_done")
      respond_with :admin, @resource, location: nearest_index_path
    else
      flash[:error] = [
        t("controllers.flash.delete_error"),
        @resource.errors.full_messages.join("\n"),
      ].join("\n").html_safe
      url = Rails.application.routes.recognize_path(request.referrer)
      respond_with :admin, @resource, location: {action: url[:action]}
    end
  end

  protected

  # def get_last_active_cookie
  #   @last_active_tab = cookies['last_active_tab']
  # end

  def after_update_location
    nearest_index_path unless params[:commit] == I18n.t("form.apply")
  end

  def after_create_location
    params[:commit] == I18n.t("form.apply") && @resource.id ? {action: :edit, id: @resource.id} : nearest_index_path
  end

  def nearest_index_path
    {action: :index}
  end

  def nearest_index_url
    url_for [:admin, resource_class.model_name.route_key, nearest_index_url_params]
  end

  def nearest_index_url_params
    nearest_index_path.except(:action) if nearest_index_path.is_a? Hash
  end

  def params_group_name
    params[:controller].sub("admin/", "").singularize.tr("/", "_")
  end

  def query_class
    "#{params[:controller].sub("admin/", "").singularize.classify.pluralize}Query".constantize
  end

  def resource_class
    params[:controller].sub("admin/", "").singularize.classify.constantize
  end

  def resource_params
    params.require(params_group_name).permit!
  end

  def redirect_from_slug
    return unless resource_class.respond_to?(:friendly_id) && params[:id].friendly_id?
    @resource = resource_class.friendly.find(params[:id])
    redirect_to(action: params[:action], id: @resource.id)
  end

  # def check_for_creatable_nested
  #   CREATABLE_OBJECTS.map do |object|
  #     next unless resource_params[object[:attr]]
  #     resource_params[object[:attr]] = resource_params[object[:attr]].map do |x|
  #       if x.starts_with?(INDICATE_NEW_PREFIX)
  #         object[:model_class].find_or_create_by!(title: x[INDICATE_NEW_PREFIX.length..-1], locale: params_region.locale).id
  #       else
  #         x
  #       end
  #     end
  #   end
  # end
end
