module API
  module V1
    class ArticleResource < BaseResource
      immutable

      attributes :title, :created_at

      def self.records(options = {})
        super
      end
    end
  end
end
