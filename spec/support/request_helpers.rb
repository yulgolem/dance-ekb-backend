module Requests
  module JsonHelpers
    def json
      @json ||= HashWithIndifferentAccess.new JSON.parse(response_body)
    end

    def included_ids_by_type
      @included_ids_by_type ||= Hash[json[:included]
        .group_by { |x| x[:type].to_sym }
        .map { |k, v| [k, v.map { |e| e[:id].to_i }] }]
    end

    def data_ids
      @data_ids ||= json[:data].map { |e| e[:id].to_i }
    end

    def data_string_ids
      @data_string_ids ||= json[:data].map { |e| e[:id] }
    end

    # def json_headers
    #   {
    #     "Accept" => "application/json",
    #     "Content-Type" => "application/json"
    #   }
    # end
  end
end
