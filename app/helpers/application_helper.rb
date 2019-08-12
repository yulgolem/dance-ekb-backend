module ApplicationHelper
  ALERT_TYPES = %i[success info warning error].freeze unless const_defined?(:ALERT_TYPES)

  def flash_message(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :error  if type == :alert
      type = :error  if type == :danger
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div, msg, class: "ui #{type} compact message #{options[:class]}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def accusative(model_class)
    I18n.t("activerecord.models.#{model_class.model_name.collection.singularize}.accusative")
  end

  def genitive(model_class)
    I18n.t("activerecord.models.#{model_class.model_name.collection.singularize}.few")
  end

  # Enum i18n helpers https://mikerogers.io/2016/05/19/improving-rails-enums-using-i18n.html
  def enum_options_for_select(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |k, _v|
      [enum_i18n(class_name, enum, k), k]
    end
  end

  def enum_l(model, enum)
    enum_i18n(model.class, enum, model.send(enum))
  end

  def enum_i18n(class_name, enum, key)
    I18n.t("activerecord.attributes.#{class_name.model_name.i18n_key}.#{enum.to_s.pluralize}.#{key}")
  end

  def array_i18n(class_name, array, value)
    I18n.t("activerecord.attributes.#{class_name.model_name.i18n_key}.#{array.to_s.singularize}_values.#{value}")
  end
end
