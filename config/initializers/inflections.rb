# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym "API"
  inflect.acronym "VK"
  inflect.acronym "HR"
end

ActiveSupport::Inflector.inflections(:ru) do |inflect|
  translations = YAML.load_file("config/locales/ru.yml")
  translations.fetch("ru", {}).fetch("activerecord", {})
    .fetch("models", {}).each do |_k, v|
    inflect.irregular v["one"], v["countless"] if v["countless"].present?
  end
end
