# class RestResourceGenerator < Rails::Generators::NamedBase
#   source_root File.expand_path('../templates', __FILE__)
#
#   TRANSLATE_OPTION = 'tr'.freeze
#
#   argument :attributes,
#            type: :array,
#            default: [],
#            banner: 'field[:type][:index][:tr] field[:type][:tr][:index]'
#
#   class_option :admin, type: :boolean, default: true, desc: 'Generate admin files'
#   class_option :api, type: :boolean, default: false, desc: 'Generate API files'
#
#   attr_accessor :raw_attributes
#   attr_accessor :translated_attributes
#   attr_accessor :nontranslated_attributes
#
#   def run_model_generator
#     puts 'Attributes:', attributes.map(&:name)
#     generate 'model', name, *raw_attributes
#   end
#
#   def add_translated_attributes
#     return unless translated_attributes.present?
#     inject_into_class File.join('app/models', class_path, "#{file_name}.rb"), class_name do
#       "  translates #{translated_attributes.map { |a| ":#{a}" }.join(', ')}, fallback: false\n"
#     end
#   end
#
#   def run_factory_bot_generator
#     return unless options['api']
#     template 'factories.rb.erb', File.join('spec/factories', plural_file_name + '.rb')
#   end
#
#   def create_api_spec
#     return unless options['api']
#     template 'spec.rb.erb', File.join('spec/acceptance/api/v1', "#{plural_file_name}_spec.rb")
#   end
#
#   def create_seed_files
#     template 'seeds.rb.erb', File.join('db/seed', "#{plural_file_name}.rb")
#     append_to_file 'db/seeds.rb', "\nSeeder.seed('#{plural_file_name}')"
#   end
#
#   def run_presenter_generator
#     return unless options['admin']
#     generate 'showcase:presenter', name
#   end
#
#   def create_admino_query
#     return unless options['admin']
#     template 'query.rb.erb', File.join('app/queries', class_path, "#{plural_file_name}_query.rb")
#   end
#
#   def create_admin_controller
#     return unless options['admin']
#     template 'admin_controller.rb.erb', File.join('app/controllers/admin', class_path, "#{plural_file_name}_controller.rb")
#   end
#
#   def add_admin_partials
#     return unless options['admin']
#     template 'partials/_form_fields.html.slim.erb', File.join('app/views/admin', class_path, "#{plural_file_name}/_form_fields.html.slim")
#     template 'partials/_index_row.html.slim.erb', File.join('app/views/admin', class_path, "#{plural_file_name}/_index_row.html.slim")
#   end
#
#   # def create_api_controller
#   #   return unless options['api']
#   #   template 'api_controller.rb.erb', File.join('app/controllers/api/v1', class_path, "#{plural_file_name}_controller.rb")
#   # end
#   #
#   # def create_api_resource
#   #   return unless options['api']
#   #   template 'api_resource.rb.erb', File.join('app/resources/api/v1', class_path, "#{file_name}_resource.rb")
#   # end
#
#   def add_routes
#     return unless options['api'] && options['admin']
#     log :route, "add :#{plural_file_name} to public_resources"
#     gsub_file 'config/routes.rb',
#               /public_resources = %i\[(.*?)\]/m,
#               "public_resources = %i[\\1  #{plural_file_name}\n  ]"
#   end
#
#   def add_translation_draft
#     return unless options['admin']
#     result = "
# #{file_name}:
#   one:
#   few:
#   many:
#   countless:
#   accusative:
# #{file_name}:
# "
#     (translated_attributes + nontranslated_attributes).each { |attr| result += "  #{attr}:\n" }
#     append_to_file 'config/locales/ru.yml', result
#   end
#
#   def log_todo
#     log 'Do not forget to:'
#     log '  - update translations'
#     log '  - update ability.rb'
#     log '  - update admin layout'
#   end
#
#   private
#
#   def plural_class_name
#     (class_path + [plural_file_name]).map!(&:camelize).join('::')
#   end
#
#   def parse_attributes!
#     self.raw_attributes = []
#     self.translated_attributes = []
#     self.nontranslated_attributes = []
#     self.attributes = (attributes || []).map do |attr|
#       splitted_attr = attr.split(':')
#       if splitted_attr.include?(TRANSLATE_OPTION)
#         translated_attributes << splitted_attr.first
#         clean_attr = splitted_attr.reject { |v| v == TRANSLATE_OPTION }
#         ru_attr = clean_attr.dup
#         ru_attr[0] += '_ru'
#         ru_attr = ru_attr.join(':')
#         en_attr = clean_attr.dup
#         en_attr[0] += '_en'
#         en_attr = en_attr.join(':')
#         raw_attributes << ru_attr
#         raw_attributes << en_attr
#         [
#           Rails::Generators::GeneratedAttribute.parse(ru_attr),
#           Rails::Generators::GeneratedAttribute.parse(en_attr)
#         ]
#       else
#         nontranslated_attributes << splitted_attr.first
#         raw_attributes << attr
#         Rails::Generators::GeneratedAttribute.parse(attr)
#       end
#     end.flatten
#   end
# end
