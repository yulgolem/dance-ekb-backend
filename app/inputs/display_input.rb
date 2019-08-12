class DisplayInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    if input_html_options.key?(:value)
      value = input_html_options[:value]
    else
      value = object.public_send(attribute_name)
      value = template.present(value).title if value.is_a? ApplicationRecord
    end
    template.content_tag(:div) do
      template.concat value
    end
  end
end
