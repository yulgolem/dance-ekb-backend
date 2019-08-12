class ImagePreviewInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    # :preview_version is a custom attribute from :input_html hash, so you can pick custom sizes

    input_html_classes.push "input-invisible"
    version = input_html_options[:preview_version]
    version ||= :original

    out = ActiveSupport::SafeBuffer.new # the output buffer we're going to build
    # check if there's an uploaded file (eg: edit mode or form not saved)

    img_class = input_html_options.delete(:img_class) || "img-thumbnail ui rounded bordered image"
    img_width = input_html_options.delete(:img_width) || "300"
    placeholder_path = template.image_path "admin/photo.png"

    if object.send(attribute_name.to_s)
      # append preview image to output
      image_url = object.send(attribute_name)[version].send("url")
      if image_url.include?("/uploads/cache/")
        # this fixes initial image display when duplicating record with images via admin interface
        image_url.gsub!(/.*\/uploads\/cache\//, "/uploads/cache/")
      end
      out << template.image_tag(image_url, width: img_width, class: img_class, data: {placeholder: placeholder_path})
    else
      out << template.image_tag("admin/photo.png", width: img_width, class: img_class, data: {placeholder: placeholder_path})
    end
    # append file input. it will work accordingly with your simple_form wrappers
    out << @builder.file_field(attribute_name, input_html_options)
  end
end
