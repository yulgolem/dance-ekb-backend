# frozen_string_literal: true

module HumanErrorMessage
  def graphql_human_error_messages(model, relation: false)
    # prepare errors for Types::ErrorType

    # human_error_messages.is_a { attr => errors.join(". ") }

    # regex /(Data)\z/ used to remove shrine `_data` json fields suffix
    # as these fields used without `Data` on frontend

    return [] unless model.present?
    if relation
      model.human_error_messages.map do |error_hash|
        {
          type: "#{model.class.name.camelize(:lower)}.#{error_hash.keys[0].to_s.camelcase(:lower)}".gsub(/(Data)\z/, ""),
          uuid: model.uuid,
          message: error_hash.values[0],
        }
      end
    else
      model.human_error_messages.map do |error_hash|
        {
          type: error_hash.keys[0].to_s.camelcase(:lower).gsub(/(Data)\z/, ""),
          message: error_hash.values[0],
        }
      end
    end

    # common error example
    # [
    #   ...
    #   {
    #     "type": "photo",
    #     "message": "Пожалуйста, загрузите файл"
    #   },
    #   ...
    # ]

    # relation error example
    # [
    #   ...
    #   {
    #     "type": "educationFacilities.startYear",
    #     "uuid": uuid_pointer,
    #     "message": "Пожалуйста, выберите значение"
    #   },
    #   ...
    # ]
  end
end
