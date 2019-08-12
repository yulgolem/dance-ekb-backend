JSONAPI.configure do |config|
  # built in paginators are :none, :offset, :cursor, :paged
  config.json_key_format = :underscored_key
  config.route_format = :underscored_route

  config.default_paginator = :paged
  config.top_level_links_include_pagination = false
  config.top_level_meta_include_record_count = true

  config.default_page_size = 2000
  config.maximum_page_size = 2000

  # config.allowed_request_params = [:include, :fields, :format, :controller, :action, :sort, :page]
  # config.use_text_errors = false

  config.always_include_to_one_linkage_data = true
end

module JSONAPI
  module Exceptions
    class ActionForbidden < Error
      def errors
        [JSONAPI::Error.new(code: JSONAPI::FORBIDDEN,
                            status: :forbidden,
                            title: "Action is forbidden",
                            detail: "Action is forbidden")]
      end
    end
  end
end

class DynamicIncludeChecker
  def initialize(checker_proc)
    @checker_proc = checker_proc
  end

  def include?(obj)
    @checker_proc.call(obj)
  end
end
