# frozen_string_literal: true

class SemanticUiCheckBoxesInput < SimpleForm::Inputs::CollectionCheckBoxesInput
  def input
    label_method, value_method = detect_collection_methods
    input_options = {
      item_wrapper_tag: "div",
      item_wrapper_class: "ui checkbox field",
      collection_wrapper_tag: "div",
      collection_wrapper_class: "grouped inline fields",
    }

    @builder.send(
      "collection_check_boxes",
      attribute_name,
      collection,
      value_method,
      label_method,
      input_options,
      input_html_options,
      &collection_block_for_nested_boolean_style
    )
  end
end
