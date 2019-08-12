# # can't find table ``

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def human_error_messages
    raise "Human error messages not defined for #{I18n.locale} locale" unless I18n.locale == :ru
    class_name = model_name.element
    errors.details.map do |attr, attr_errors|
      errors = attr_errors.map { |attr_error|
        I18n.t("activerecord.errors.models.#{class_name}.attributes.#{attr}._human.#{attr_error[:error]}")
      }
      {attr => errors.join(". ")}
    end
  end

  # TODO: remove after every mutation will work through form object
  def graphql_human_error_messages
    # prepare for Types::ErrorType
    human_error_messages.map { |x| {type: x.keys[0].to_s.camelcase(:lower), message: x.values[0]} }
  end
end
