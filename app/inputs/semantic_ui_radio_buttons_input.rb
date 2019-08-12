# frozen_string_literal: true

class SemanticUiRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input
    label_method, value_method = detect_collection_methods
    input_options = {
      item_wrapper_tag: "div",
      item_wrapper_class: "field",
      collection_wrapper_tag: "div",
      collection_wrapper_class: "grouped inline fields",
    }
    @builder.send(
      "collection_radio_buttons",
      attribute_name,
      collection,
      value_method,
      label_method,
      input_options,
      input_html_options,
      &collection_block_for_nested_boolean_style
    )
  end

  protected

  def build_nested_boolean_style_item_tag(collection_builder)
    (
      '<div class="ui radio checkbox">' +
      collection_builder.radio_button + collection_builder.label +
      "</div>"
    ).html_safe
  end
end
