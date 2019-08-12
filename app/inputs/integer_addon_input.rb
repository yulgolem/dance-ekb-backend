class IntegerAddonInput < SimpleForm::Inputs::NumericInput
  def input
    input_html_classes.unshift("numeric")

    if html5?
      input_html_options[:type] ||= "number"
      input_html_options[:step] ||= 1
      input_html_options[:min] ||= 0
    end

    input_html_classes << "ui fluid input"

    template.content_tag(:div, class: "ui right labeled input") do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat template.content_tag(:div, addon.html_safe, class: "ui basic label")
    end
  end

  def addon
    raise "override me"
  end
end
