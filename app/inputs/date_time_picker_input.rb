class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    template.content_tag(:div, class: "ui calendar") do
      template.content_tag(:div, class: "ui input left icon") do
        template.concat calendar_icon
        template.concat @builder.text_field(attribute_name, input_html_options)
      end
    end
  end

  def calendar_icon
    '<i class="calendar icon"></i>'.html_safe
  end
end
