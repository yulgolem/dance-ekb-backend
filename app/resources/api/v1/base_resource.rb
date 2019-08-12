module API
  module V1
    class BaseResource < JSONAPI::Resource
      attr_accessor :context # writer for context
      abstract

      def self.serializer_cache(val = true, expires_in = nil)
        @serializer_cache = val
        @serializer_cache_expires_in = expires_in
      end

      def self._serializer_cache_expires_in
        @serializer_cache_expires_in
      end

      def self._serializer_cache
        @serializer_cache
      end

      def _serializer_cache
        self.class._serializer_cache
      end

      def _serializer_cache_expires_in
        self.class._serializer_cache_expires_in
      end

      def self.records(options = {})
        _model_class.accessible_by(options[:context][:current_ability])
      end

      def records_for(relation_name)
        records = super

        if records.is_a? ActiveRecord::Associations::CollectionProxy
          records = records.accessible_by(context[:current_ability])
        elsif records.is_a?(ActiveRecord::Base)
          # Rails.logger.info "#{records.id}"
          unless context[:current_ability].can? :read, records
            records = nil
          end
        elsif !records.nil?
          raise "Unexpected class #{records.class}"
        end
        records
      end

      def self.fetchable_fields(context)
        fields_for_action(context || {})[:action]
      end

      def self.find(filters, options = {})
        if _relationships && _relationships[:target] && _relationships[:target].options && _relationships[:target].options[:polymorphic]
          ActiveRecord.lax_includes do
            # ... record with missing association are filtered out instead of raising an error
            super
          end
          # back to normal `Association named '****' was not found; perhaps you misspelled it?` exception.
        else
          super
        end
      end

      def self.find_by_key(key, options = {})
        if _model_class.respond_to?(:friendly_id) && key.friendly_id?
          fail JSONAPI::Exceptions::RecordNotFound.new(key) if key.blank?
          context = options[:context]
          records = records(options)
          records = apply_includes(records, options)
          model = records.where({slug: key}).first
          fail JSONAPI::Exceptions::RecordNotFound.new(key) if model.nil?
          new(model, context)
        else
          super
        end
      end

      def self.fields_for_action(action)
        action = action.to_sym if action
        fields - \
          _attributes.select { |k, o| o[:action] && o[:action] != action }.keys - \
          _relationships.select { |k, r| r.options && r.options[:action] && r.options[:action] != action }.keys
      end

      def self.inherited(base)
        super
        base.init_base unless base._abstract || base._model_name.to_s.safe_constantize.nil?
      end

      def self.init_base
        if _model_class.respond_to? :friendly_id
          attribute :slug
          key_type :string
        end
      end

      def cache_key
        Rails.cache.send(:expanded_key, [_model.cache_key, context.except(:current_ability, :remote_ip).merge(current_user: context[:current_user].try(:cache_key))])
      end
    end
  end
end
