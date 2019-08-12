class APISerializer < JSONAPI::ResourceSerializer
  CACHE_KEY_NAMESPACE = "api_serializer"

  def initialize(primary_resource_klass, options = {})
    @primary_resource_klass = primary_resource_klass
    super
  end

  def serialize_to_hash(source)
    if (@primary_resource_klass <= API::V1::BaseResource) && @primary_resource_klass._serializer_cache

      source_key = source.respond_to?(:to_ary) ? source.map(&:cache_key) : source.cache_key
      key = Rails.cache.send(:expanded_key, [
        source_key,
        I18n.locale,
        @fields,
        @include,
        @include_directives.try(:include_directives),
        @serialization_options,
      ])
      # puts key
      cache_key = [CACHE_KEY_NAMESPACE, Digest::SHA256.hexdigest(key)]
      # puts Rails.cache.send(:expanded_key, cache_key)
      Rails.cache.fetch(cache_key, expires_in: @primary_resource_klass._serializer_cache_expires_in) do
        super
      end
    else
      super
    end
  end

  # override to enable :include action scope for fetchable attributes
  def object_hash(source, include_directives)
    source.context ||= {}
    source.context[:action] ||= nil

    action = include_directives[:include] ? :include : source.context[:action]
    action_was = source.context[:action]
    source.context[:action] = action if action_was != action

    obj_hash = super

    source.context[:action] = action_was if action_was != action
    obj_hash
  end

  # disable links feature, as we do not use it at all
  def relationship_links(source)
    {}
  end

  def link_object(source, relationship, include_linkage = false)
    super.tap do |object|
      object.delete(:links)
    end
  end
end
