module ResourceUrlsConcern
  extend ActiveSupport::Concern

  included do
    helper_method :edit_resource_url,
                  :delete_resource_url,
                  :resource_url,
                  :new_resource_url,
                  :collection_url,
                  :custom_resource_url
  end

  private

  def delete_resource_url(resource)
    resource_url(resource)
  end

  def edit_resource_url(resource)
    url_for(controller: controller_path, action: :edit, id: resource)
  end

  def resource_url(resource, options = {})
    url_for(options.merge(controller: controller_path, action: :show, id: resource))
  end

  def new_resource_url(options = {})
    url_for(options.merge(controller: controller_path, action: :new))
  end

  def collection_url
    url_for(controller: controller_path, action: :index)
  end

  def custom_resource_url(resource, action)
    url_for(controller: resource.class.name.underscore.pluralize, action: action, id: resource.id)
  end
end
